
train <- train %>% mutate(filter="train")
test <- test %>% mutate(filter="test")
all_comments <- train %>% bind_rows(test)

all_comments.features[is.na(all_comments.features)] <- 0
is.infinite.data.frame <- function(x)
  do.call(cbind, lapply(x, is.infinite))
all_comments.features[is.infinite(all_comments.features)] <- 0
is.nan.data.frame <- function(x)
  do.call(cbind, lapply(x, is.nan))
all_comments.features[is.nan(all_comments.features)] <- 0

# Calculate stopwords and rarewords
stop_words_chr <- c(stopwords("en")) %>% c(stopwords.en$C1) %>% c(stopwords.custom)
#stop_words_chr <- c(stopwords("en")) 

# Vectorizer
vectorizer.dict <- create_vocabulary(all_comments.clean, ngram = c(1L, 1L), stopwords = stop_words_chr) %>%
  prune_vocabulary(term_count_min = 4, doc_proportion_max = 0.3, vocab_term_max = 10000) %>%
  vocab_vectorizer()



m_tfidf <- TfIdf$new(norm = "l2", sublinear_tf = T)
tfidf <- create_dtm(all_comments.clean, vectorizer.dict) %>%
  fit_transform(m_tfidf)  
m_lsa <- LSA$new(n_topics = 25, method = "randomized")
lsa <- fit_transform(tfidf, m_lsa)




# Preparing data for glmnet
all_comments.matrix <- all_comments.features %>% 
  select(-comment_text) %>% 
  sparse.model.matrix(~ . - 1, .) %>% 
  cbind(tfidf, lsa)


# Prepare train and test set
train.set <- all_comments[, "filter"] == "train"
test.set <- all_comments[, "filter"] == "test"
train.matrix <- all_comments.matrix[train.set,]
test.matrix <- all_comments.matrix[test.set,]

subm <- data.frame(id = test$id)

# Training glmnet & predict toxicity
for (target in c("toxic", "severe_toxic", "obscene", "threat", "insult", "identity_hate")) {
  cat("\nTrain -->", target, "...")
  y <- train[[target]]
  glm.model <- cv.glmnet(train.matrix, factor(y), alpha = 0, family = "binomial", type.measure = "auc",
                         parallel = T, standardize = T, nfolds = 10, nlambda = 50,weights=word_embed)
  cat(" AUC:", max(glm.model$cvm))
  subm[[target]] <- predict(glm.model, test.matrix, type = "response", s = "lambda.min")
}

head(subm)
nrow(subm) #153164
write.csv(subm, 'submission.csv', row.names = FALSE)


subm <- data.frame(id = test$id)
# Training xgboost & predict toxicity
for (target in c("toxic", "severe_toxic", "obscene", "threat", "insult", "identity_hate")) {
  cat("\nTrain -->", target, "...")
  y <- train[,target]
  m_xgb <- xgboost(train.matrix, y, params = p, print_every_n = 100, nrounds = 500)
  cat(" AUC:", max(m_xgb$evaluation_log$train_auc))
  subm[[target]] <- predict(m_xgb, test.matrix)
}


head(subm)
nrow(subm) #153164
write.csv(subm, 'submission2.csv', row.names = FALSE)

