from sklearn.feature_extraction.text import CountVectorizer
import matplotlib.pyplot as plt
from wordcloud import WordCloud
import pandas as pd
import re


# function for removing numbers
def removeNumbers(numbers):
    noNumbers = re.sub('[0-9]+', '', numbers)
    return noNumbers


# function for removing punctuation
def removePunctuation(text):
    noPunctuation = re.sub('!|\.|\?|\"|\'|-|\$|:|;|_|,|%', ' ', text)
    return noPunctuation


# function for transforming words to their stems
def wordStem(word, stem):
    word = re.sub(stem+'(d|ed|ing)', stem, word)
    return word


def stripWhiteSpace(text):
    text.strip()
    return text

# store hotel reviews in data frame
hotelReviews = pd.read_csv("../data/hotelReviews.csv")

# remove numbers from text
hotelReviews['text'] = hotelReviews['text'].apply(removeNumbers)

# remove white space
hotelReviews['text'] = hotelReviews['text'].apply(stripWhiteSpace)

# remove punctuation from text
hotelReviews['text'] = hotelReviews['text'].apply(removePunctuation)

# stems variants of the word 'use' (i.e. 'used' and 'using' get mapped to 'use)
hotelReviews['text'] = hotelReviews['text'].apply(wordStem, stem='use')

# create an object for converting a collection of text documents to a matrix of token counts
# using the 'english' stop words set and generating a vocabulary of terms with at least one entry
vectorizer = CountVectorizer(min_df=1, stop_words='english', lowercase=True)

# create term-document matrix of given text documents
vectorizer.fit_transform(hotelReviews['text'])  # returns scipy.sparse.csr.csr_matrix

# prints features (i.e. terms) in alphabetical order
print(vectorizer.get_feature_names())

# prints mapping of terms to feature indices
print(vectorizer.vocabulary_)

# create and display word cloud
wordcloud = WordCloud().generate(" ".join(list(hotelReviews['text'])))
plt.imshow(wordcloud)
plt.show()



