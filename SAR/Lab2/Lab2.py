#! -*- encoding: utf8 -*-
# inspired by Lluís Ulzurrun and Víctor Grau work

"""
2-. Cuenta palabras

Alemany Ibor, Sergio
Galindo Jiménez, Carlos Santiago
"""

from operator import itemgetter
import re
import sys

clean_re = re.compile('\W+')
def clean_text(text):
    return clean_re.sub(' ', text)

def sort_dic(d):
    for key, value in sorted(sorted(d.items()), key=itemgetter(1), reverse=True):
        yield key, value

def text_statistics(filename, to_lower=True, remove_stopwords=True):
    # TODO bigramas $ sentence $
    text = open(filename, 'r', encoding='utf8')
    lines = 0
    num_words = 0
    num_letters = 0
    word_dic = {}
    letter_dic = {}
    stopwords = []
    for w in open('stopwords_en.txt', 'r', encoding='utf8'):
        stopwords += w

    # Main loop
    for line in text:
        # Lowercase
        if to_lower:
            line = line.lower()

        for word in line.split():
#            print(word)
            # Remove symbols TODO midword
            while 0 < len(word) and not word[0].isalpha():
                word = word[1:]
            while 0 < len(word) and not word[-1].isalpha():
                word = word[:-1]
                if len(word) == 0: break

            # Remove stopwords
            if remove_stopwords and word in stopwords:
                break

            # Add word to dictionary
            word_dic[word] = word_dic.get(word, 0) + 1
            num_words += 1

            # Analyze chars
            for char in word:
                # Add char to dictionary
                letter_dic[char] = letter_dic.get(char, 0) + 1
                num_letters += 1
        lines += 1

    # Print info
    print ("Lines: %d" % lines)
    print ("Number words (with%s stopwords): %d" % ("out" if remove_stopwords else "", num_words))
    print ("Vocabulary size: %d" % len(word_dic.keys()))
    print ("Number of symbols: %d" % num_letters)
    print ("Number of different symbols: %d" % len(letter_dic.keys()))

    print ("Words (alphabetical order):")
    for word, count in sorted(word_dic.items()):
        print("\t%s\t%d" % (word, count))
    print ("Words (by frequency):")
    for word, count in sort_dic(word_dic):
        print("\t%s\t%d" % (word, count))
    print ("Symbols (alphabetical order):")
    for letter, count in sorted(letter_dic.items()):
        print("\t%s\t%d" % (letter, count))
    print ("Symbols (by frequency):")
    for letter, count in sort_dic(letter_dic):
        print("\t%s\t%d" % (letter, count))

def syntax():
    print ("\n%s filename.txt [to_lower?[remove_stopwords?]]\n" % sys.argv[0])
    sys.exit()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        syntax()
    name = sys.argv[1]
    lower = False
    stop = False
    if len(sys.argv) > 2:
        lower = (sys.argv[2] in ('1', 'True', 'yes'))
        if len(sys.argv) > 3:
            stop = (sys.argv[3] in ('1', 'True', 'yes'))
    text_statistics(name, to_lower=lower, remove_stopwords=stop)