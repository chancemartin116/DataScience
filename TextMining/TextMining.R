library(tm) # text mining package
library(SnowballC) # word stemming package
library(wordcloud) # word cloud visualization

# store hotel reviews in data frame
hotelReviews <- read.csv("data/hotelReviews.csv", stringsAsFactors = FALSE)

# convert rating column to factor type
hotelReviews$rating <- factor(hotelReviews$rating)

# examine the structure of the hotel review data
str(hotelReviews)

# examine the ratings variable more carefully
str(hotelReviews$rating)

# display count of each type of rating
table(hotelReviews$rating)

# interprets each element of text as a document
vs <- VectorSource(hotelReviews$text)

# build a corpus (collection of written texts) 
ratings_corpus <- VCorpus(vs)

# display info about corpus
inspect(ratings_corpus)

# apply as.character function to each subset of each group of texts
lapply(ratings_corpus[1:2], as.character)
 
# tm_map() -> mapping function in tm library
# content_transformer() -> tm wrapper function to access corpus and use non-tm functions like tolower() to turn all text into lowercase
# Note: can use custom functions instead of built-in like tolower()
ratings_corpus_clean <- tm_map(ratings_corpus, content_transformer(tolower))

# show the difference between sms_corpus and corpus_clean
lapply(ratings_corpus_clean[1:2], as.character)
 
# remove numbers as they do not usually provided pertinent info
ratings_corpus_clean <- tm_map(ratings_corpus_clean, removeNumbers) 

# remove words like "but", "and", "or", "as"
# Note: can replace stopwords() with list of user defined words
ratings_corpus_clean <- tm_map(ratings_corpus_clean, removeWords, stopwords()) 

# built in removePunctuation function turns "hello.....world" into "helloworld"
# instead create own function to remove punctuation without joining separate words
replacePunctuation <- function(x) { gsub("[[:punct:]]+", " ", x) }
replacePunctuation("hello...world")
ratings_corpus_clean <- tm_map(ratings_corpus_clean, content_transformer(replacePunctuation)) # must use content_transformer
lapply(ratings_corpus_clean[1:2], as.character)

# stems variants of the word "learn"(i.e. each variant maps to the word "learn")
wordStem(c("learn", "learned", "learning", "learns"))

# stemDocument() applies wordStem to entire corpus of text
ratings_corpus_clean <- tm_map(ratings_corpus_clean, stemDocument)

# eliminate unneeded whitespace
ratings_corpus_clean <- tm_map(ratings_corpus_clean, stripWhitespace) 
 
# examine the final clean corpus
lapply(ratings_corpus[1:3], as.character)
lapply(ratings_corpus_clean[1:3], as.character)

# create a document-term sparse matrix, rows are the hotel reviews and columns are the words
# a sparse matrix has mostly zero values
# the following 3 solutions apply DocumentTermMatrix to the corpus
# there are slight differences due to the order and implementation of preprocessing steps
ratings_dtm <- DocumentTermMatrix(ratings_corpus_clean)
 
# alternative solution: create a document-term sparse matrix directly from the SMS corpus
ratings_dtm2 <- DocumentTermMatrix(ratings_corpus, control = list(
	tolower = TRUE,
	removeNumbers = TRUE,
	stopwords = TRUE,
	removePunctuation = TRUE,
	stemming = TRUE
))

# alternative solution: using custom stop words function ensures identical result
ratings_dtm3 <- DocumentTermMatrix(ratings_corpus, control = list(
	tolower = TRUE,
	removeNumbers = TRUE,
	stopwords = function(x) { removeWords(x, stopwords()) },
	removePunctuation = TRUE,
	stemming = TRUE
))

# compare the result
ratings_dtm
ratings_dtm2
ratings_dtm3

# creating training and test datasets
ratings_dtm_train <- hotelReviews[1:40, ]
ratings_dtm_test  <- hotelReviews[41:50, ]

# also save the labels
ratings_train_labels <- hotelReviews[1:40, ]$rating
ratings_test_labels  <- hotelReviews[41:50, ]$rating

# check that the proportion of spam is similar
prop.table(table(ratings_train_labels))
prop.table(table(ratings_test_labels))

# creates visual representation of word frequency in document
pal <- brewer.pal(6,"Dark2") # creates color palette
wordcloud(ratings_corpus_clean, min.freq=1, random.order=FALSE, colors=pal)

