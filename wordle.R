library(stringr)
library(dplyr)
library(ggplot2)
library(data.table) # for fread and fwrite functions

source("utils.R")
source("find_best_words.R")
source("narrow_word_list.R")

word_list <- read.delim("words.txt", 
                        header=FALSE, 
                        col.names=c("word"))

answers_list = read.csv("wordle-answers-alphabetical.txt", 
                        col.names=c("word"))


# Takes 2-3 hours to score full list of 5-letter
# words agains the 2300 possible answers
# source("create_combo_list.R")
# combo_list = 
#   create_combo_list(word_list, answers_list)
#fwrite(combo_list, file="combo_list.csv", row.names=FALSE)

combo_list = fread("combo_list.csv")

t = Sys.time()
word_scores = find_mean_bits_remaining(combo_list = combo_list, answers_list)
Sys.time()-t #31 seconds! finds roate as best word

t = Sys.time()
updated_list <- narrow_word_list(word_list=answers_list, 
                                 guess="soare", result="yxyxg",
                                 combo_list = combo_list)

find_mean_bits_remaining(combo_list = combo_list, updated_list)

updated_list <- narrow_word_list(word_list=updated_list, 
                                 guess="aisle", result="yxyyg",
                                 combo_list = combo_list)
Sys.time()-t
# only mourn remaining

updated_list <- narrow_word_list(word_list=updated_list, 
                                 guess="essay", result="yxxgx",
                                 combo_list = combo_list)
