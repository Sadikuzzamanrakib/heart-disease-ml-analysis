df <- read.csv("C:/ML Project/heart_disease_uci.csv", header = TRUE, stringsAsFactors = FALSE)

#handles all preprocessing
library(dplyr)
library(caret)
library(pROC)


#Replace “?” with NA and convert data type
df[df == "?"] <- NA
numeric_cols <- c("age", "trestbps", "chol", "thalch", "oldpeak", "ca", "num")
df[numeric_cols] <- lapply(df[numeric_cols], function(x) as.numeric(x))

factor_cols <- c("sex", "cp", "fbs", "restecg", "exang", "slope", "thal")
df[factor_cols] <- lapply(df[factor_cols], factor)


#Create a binary target
df$target <- ifelse(df$num == 0, "NoHD", "HD")
df$target <- factor(df$target)


#Drop rows with any NA
df_clean <- na.omit(df)


#Train/test split
set.seed(42)
idx <- createDataPartition(df_clean$target, p = 0.8, list = FALSE)
train <- df_clean[idx, ]
test  <- df_clean[-idx, ]


#Train control
ctrl <- trainControl(method = "cv", number = 10,
                     classProbs = TRUE, summaryFunction = twoClassSummary)

pred <- predict(lr_fit, newdata = test)
confusionMatrix(pred, test$target)


probs <- predict(lr_fit, newdata = test, type = "prob")[, "HD"]
roc_obj <- roc(test$target, probs)
plot(roc_obj, main = "ROC Curve - Logistic Regression")


#Missing values Handling
summary(train)
colSums(is.na(train))

train_clean <- na.omit(train)
library(dplyr)
train_clean <- train %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)))

#which columns have missing data
colSums(is.na(train))
train[train == "?"] <- NA
#Convert numeric columns properly
train$ca     <- as.numeric(train$ca)
train$thalch <- as.numeric(train$thalch)
train$oldpeak <- as.numeric(train$oldpeak)
train$chol   <- as.numeric(train$chol)
train$trestbps <- as.numeric(train$trestbps)
#Remove rows with missing values
train_clean <- na.omit(train)

library(dplyr)

train_clean <- train %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)))





# Convert categorical variables to factors
df$sex     <- factor(df$sex)
df$cp      <- factor(df$cp)
df$restecg <- factor(df$restecg)
df$slope   <- factor(df$slope)
df$thal    <- factor(df$thal)
df$exang   <- factor(df$exang)
df$fbs     <- factor(df$fbs)


# Target variable: num (0 = no disease, 1–4 = disease severity)
df$target <- ifelse(df$num == 0, "NoHD", "HD")
df$target <- factor(df$target)


#Train/Test Split
library(caret)

set.seed(42)
idx <- createDataPartition(df$target, p = 0.8, list = FALSE)
train <- df[idx, ]
test  <- df[-idx, ]


#Train Models

ctrl <- trainControl(method = "cv", number = 10,
                     classProbs = TRUE, summaryFunction = twoClassSummary)

# Logistic Regression
lr_fit <- train(target ~ age + sex + cp + trestbps + chol + fbs + restecg +
                  thalch + exang + oldpeak + slope + ca + thal,
                data = train, method = "glm", family = binomial(),
                trControl = ctrl, metric = "ROC")

# Decision Tree
dt_fit <- train(target ~ ., data = train, method = "rpart",
                trControl = ctrl, metric = "ROC")

# Random Forest
rf_fit <- train(target ~ ., data = train, method = "rf",
                trControl = ctrl, metric = "ROC", ntree = 200)

# SVM
svm_fit <- train(target ~ ., data = train, method = "svmRadial",
                 trControl = ctrl, metric = "ROC", tuneLength = 8)


# Predictions
pred_rf <- predict(rf_fit, newdata = test)
confusionMatrix(pred_rf, test$target)


# ROC curve example
library(pROC)
probs_rf <- predict(rf_fit, newdata = test, type = "prob")[, "HD"]
roc_rf <- roc(test$target, probs_rf)
plot(roc_rf, main = "ROC Curve - Random Forest")



#Model Comparison

library(caret)
library(pROC)
library(dplyr)

# Assume df_clean preprocessed dataset (after handling NAs, factors, etc.)
set.seed(42)

# Train/Test split
idx <- createDataPartition(df_clean$target, p = 0.8, list = FALSE)
train <- df_clean[idx, ]
test  <- df_clean[-idx, ]

# TrainControl setup
ctrl <- trainControl(method = "cv", number = 10,
                     classProbs = TRUE, summaryFunction = twoClassSummary)

# Logistic Regression
lr_fit <- train(target ~ ., data = train, method = "glm", family = binomial(),
                trControl = ctrl, metric = "ROC")

# Decision Tree
dt_fit <- train(target ~ ., data = train, method = "rpart",
                trControl = ctrl, metric = "ROC")

# Random Forest
rf_fit <- train(target ~ ., data = train, method = "rf",
                trControl = ctrl, metric = "ROC", ntree = 200)

# SVM (RBF Kernel)
svm_fit <- train(target ~ ., data = train, method = "svmRadial",
                 trControl = ctrl, metric = "ROC", tuneLength = 8)

# ---- Evaluation ----
models <- list(Logistic = lr_fit, DecisionTree = dt_fit,
               RandomForest = rf_fit, SVM = svm_fit)



results <- data.frame(
  Model = character(),
  Accuracy = numeric(),
  Precision = numeric(),
  Recall = numeric(),
  F1 = numeric(),
  ROC_AUC = numeric(),
  stringsAsFactors = FALSE
)

for (m in names(models)) {
  pred <- predict(models[[m]], newdata = test)
  probs <- predict(models[[m]], newdata = test, type = "prob")[, "HD"]
  
  cm <- confusionMatrix(pred, test$target, positive = "HD")
  roc_obj <- roc(test$target, probs)
  
  acc <- cm$overall["Accuracy"]
  prec <- cm$byClass["Precision"]
  rec <- cm$byClass["Recall"]
  f1 <- cm$byClass["F1"]
  auc <- auc(roc_obj)
  
  results <- rbind(results, data.frame(Model = m,
                                       Accuracy = acc,
                                       Precision = prec,
                                       Recall = rec,
                                       F1 = f1,
                                       ROC_AUC = auc))
}

print(results)



# Load library
library(ggplot2)

# Example results data frame (replace with your actual results)
results <- data.frame(
  Model = c("Logistic Regression", "Decision Tree", "Random Forest", "SVM"),
  Accuracy = c(0.82, 0.78, 0.88, 0.84),
  ROC_AUC  = c(0.85, 0.80, 0.91, 0.87)
)

# ---- Plot Accuracy ----
ggplot(results, aes(x = Model, y = Accuracy, fill = Model)) +
  geom_bar(stat = "identity") +
  ylim(0,1) +
  labs(title = "Model Accuracy Comparison", x = "Model", y = "Accuracy") +
  theme_minimal()

# ---- Plot ROC-AUC ----
ggplot(results, aes(x = Model, y = ROC_AUC, fill = Model)) +
  geom_bar(stat = "identity") +
  ylim(0,1) +
  labs(title = "Model ROC-AUC Comparison", x = "Model", y = "ROC-AUC") +
  theme_minimal()



Model = c("Logistic Regression", "Decision Tree", "Random Forest", "SVM"),
Accuracy = c(0.82, 0.78, 0.88, 0.84),
ROC_AUC  = c(0.85, 0.80, 0.91, 0.87)

