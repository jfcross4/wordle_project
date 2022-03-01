library(stringr)
library(dplyr)
library(ggplot2)
library(data.table) # for fread and fwrite functions

to_word = function(word){paste(word, collapse = "")}

to_vector <- function(word){str_split(to_word(word), "")[[1]]}


find_greens <- function(actual_vector, guess_vector){
  actual_vector==guess_vector
}


evaluate_guess <- function(actual, guess){
  result = rep("x", 5)
  yellow_nums = c()
  actual_vector = to_vector(actual)
  guess_vector = to_vector(guess)
  greens = find_greens(actual_vector, guess_vector)
  result[greens] = "g"
  not_yellow = (1:5)[greens]
  could_be_yellow = (1:5)[!greens]
  
  for (j in 1:5){
    
    actual_cby = actual_vector[could_be_yellow]
    guess_cby = guess_vector[could_be_yellow]
    #first_yellow = non_green_nums[is.element(guess_wo_green, actual_wo_green)][1]
    for(letter in intersect(actual_cby, guess_cby)){
      yellow_nums = c(yellow_nums, min(which(guess_vector == letter)))
    }
    yellow = (1:5) %in% yellow_nums
    could_be_yellow = (1:5)[!greens & !yellow]
  }
  result[yellow] = "y"
  return(result)
}


word_list <- read.delim("words.txt", header=FALSE, col.names=c("word"))

#words <- t(apply(word_list, 1, to_vector))


# find number of words remaining based on one guess and result pair
find_num_words <- function(word_list, guess, result){
  guess = to_vector(guess)
  result = to_vector(result)
  n = 0
  for( i in 1:nrow(word_list)){
    score <- evaluate_guess(guess=guess, actual=to_vector(word_list[i, ]))
    if(identical(score, result)){n = n+1}
    }
  return(n)
}





find_scores <- function(word_list, guess){
  nums <- rep(NA, nrow(word_list))
  scores <- rep(NA, nrow(word_list))
  words = word_list$word
  for (i in 1:nrow(word_list)){
    scores[i] <- paste(evaluate_guess(guess=guess, 
                  actual=words[i]), collapse = "")
  }
  return(table(scores))
}


# just need to count the number of times we get each score


# find_average_words_remaining <- function(word_list, guess){
#   word_table <- find_scores(word_list, guess)
#   num_possible_words <- rep(NA, length(word_table))
#   for (i in 1:length(word_table)){
#     num_possible_words[i] <- 
#       find_num_words(word_list, guess=guess, result=names(word_table)[i])
#   }
#   
#   avg_number_remaining = sum(num_possible_words*word_table)/nrow(word_list)
#   return(avg_number_remaining)
# }

# find_expected_information <- function(word_list, guess){
#   word_table <- find_scores(word_list, guess)
#   num_possible_words <- rep(NA, length(word_table))
#   for (i in 1:length(word_table)){
#     num_possible_words[i] <- find_num_words(word_list, guess=guess, result=names(word_table)[i])
#   }
#   
#   avg_number_remaining = sum(num_possible_words*word_table)/nrow(word_list)
#   return(avg_number_remaining)
# }





Sys.time() - t #2.5 s, 212 scores

# tares: 302 - good
# strap: 609 - good
# audio: 919 - fixed
# trace: 614 - fixed
# stern: 526 - fixed
# adieu: 671 - fixed
# stare: 372
# soare: 304     (best yellow letter score)
# arose: 382

# next vectorize for loop

get_entropy = function(word_list, guess){
  word_table <- find_scores(word_list, guess)
  p = word_table/nrow(word_list)
  return(-1*sum(p*log(p, base=2)))
}



get_avg_words_remaining = function(word_list, guess){
  word_table <- find_scores(word_list, guess)
  p = word_table/nrow(word_list)
  return(sum(p*word_table))
}
Sys.time()-t

t = Sys.time()
get_entropy(word_list, "tares")
Sys.time()-t


t = Sys.time()
get_avg_words_remaining(word_list, "tares")
Sys.time()-t

narrow_word_list <- function(word_list, guess, result){
  guess = to_vector(guess)
  result = to_vector(result)
  words = word_list$word
  new_word_list = c()
  n = 0
  for( i in 1:length(words)){
    score <- evaluate_guess(guess=guess, actual=to_vector(words[i]))
    if(identical(score, result)){
      new_word_list = c(new_word_list, as.character(words[i]))}
  }
  return(new_word_list = data.frame(words=new_word_list))
}

t = Sys.time()
get_avg_words_remaining(updated_list, "clone") # fast!
Sys.time()-t


### this should actually have two parameters: 
### guessable words and remaining words
find_best_words = function(word_list){
  words = word_list$word
  word_list$score <- NA
  print("starting")
  for( i in 1:nrow(word_list)){
    word_list$score[i] = 
      get_avg_words_remaining(word_list, words[i])
    print(i)
  }
  print(word_list %>% top_n(5, desc(score)) %>% arrange(score))
  return(word_list)
}

find_best_words(updated_list)

updated_list <- narrow_word_list(word_list, "lares", "xxxyx")
updated_list <- narrow_word_list(updated_list, "monie", "xyxxg")
updated_list <- narrow_word_list(updated_list, "epode", "xxgxg")
updated_list <- narrow_word_list(updated_list, "evoke", "xxggg")


updated_list <- narrow_word_list(updated_list, "globe", "xggyg")

word_scores = find_best_words(word_list)
write.csv(word_scores, file="word_scores.csv", row.names = FALSE)


find_best_words_entropy = function(word_list){
  words = word_list$word
  word_list$score <- NA
  print("starting")
  for( i in 1:length(words)){
    word_list$score[i] = 
      get_entropy(word_list, words[i])
    print(i)
  }
  print(word_list %>% top_n(5, score) %>% arrange(desc(score)))
  return(word_list)
}

word_entropy = find_best_words_entropy(word_list)
write.csv(word_entropy, file="word_entopies.csv", row.names = FALSE)

word_scores_plus = left_join(word_entropy, word_scores, by="word")

ggplot(word_scores_plus, aes(score.x, score.y)) + 
  geom_point(size=0.5, alpha=0.3, color="blue") + geom_smooth(color="red") + xlab("mean bits of information") + 
  ylab("mean words remaning")+
  ggtitle("Mean words remaining v. Mean bits of information")

answers_list = read.csv("wordle-answers-alphabetical.txt", 
                        col.names=c("answer"))

# create evaluation data
combo_list = expand.grid(word_list$word, answers_list$answer)
colnames(combo_list) = c("possible_guess", "possible_answer")

combo_list$scoring <- NA


t  = Sys.time()

possible_answers = combo_list$possible_answer
possible_guesses = combo_list$possible_guess
scores = combo_list$scoring

t  = Sys.time()
for (i in 1:5000){
  scores[i] = 
    to_word(evaluate_guess(actual=possible_answers[i], 
                           guess = possible_guesses[i]))
  if(i %% 1000 == 0){print(i)}
  }
Sys.time() - t    


for (i in 1:length(scores)){
  scores[i] = 
    to_word(evaluate_guess(actual=possible_answers[i], 
                           guess = possible_guesses[i]))
  if(i %% 10000 == 0){print(i)}
  }

combo_list$scoring = scores
#fwrite(combo_list, file="combo_list.csv", row.names=FALSE)
  #Time difference of 0.1900241 secs

test_combo_list = fread("combo_list.csv")


t = Sys.time()
nums = combo_list %>% 
  filter(possible_guess == "lares") %>% 
  dplyr::select(scoring) %>% table()


H = -1*sum(nums/sum(nums)*log(nums/sum(nums), base=2))
H
Sys.time()-t

possible_answer_results = combo_list %>% 
  filter(possible_guess == "lares" & scoring=="xxxxx")

possible_answer_results = unique(possible_answer_results$possible_answer)

updated_combo_list = combo_list %>% 
  filter(possible_answer %in% possible_answer_results)

log(length(possible_answer_results), base=2)



nums = updated_combo_list %>% 
  filter(possible_guess == "lares") %>%
  dplyr::select(scoring) %>% table()

H = -1*sum(nums/sum(nums)*log(nums/sum(nums), base=2))
H #guessing lares again has 0 value
