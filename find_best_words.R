### this should actually have two parameters: 
### guessable words and remaining words
# find_best_words_oldest = function(word_list){
#   words = word_list$word
#   word_list$score <- NA
#   print("starting")
#   for( i in 1:nrow(word_list)){
#     word_list$score[i] = 
#       get_avg_words_remaining(word_list, words[i])
#     print(i)
#   }
#   print(word_list %>% top_n(5, desc(score)) %>% arrange(score))
#   return(word_list)
# }
# 
# find_best_words_old = function(combo_list, word_list){
#   words = word_list$word
#   word_list$score <- NA
#   print("starting")
#   for( i in 1:nrow(word_list)){
#     word_list$score[i] = 
#       get_avg_words_remaining2(combo_list, words[i])
#     print(i)
#   }
#   print(word_list %>% top_n(5, desc(score)) %>% arrange(score))
#   #return(word_list)
# }

find_best_words = function(combo_list, word_list){
  possible_words = word_list$word
  num_words_remaining = length(possible_words)
  filtered_list = combo_list %>% 
    filter(possible_answer %in% possible_words)
  
  filtered_list %>% 
    group_by(possible_guess, scoring) %>% 
    summarize(n=n()) %>% 
    group_by(possible_guess) %>% 
    summarize(average_words_remaining = sum(n*n)/num_words_remaining) %>% 
    top_n(5, desc(average_words_remaining)) %>%
    arrange(average_words_remaining)
}


# find_best_words_entropy = function(combo_list, word_list){
#   combo_list = combo_list
#   words = word_list$word
#   word_list$score <- NA
#   n = length(words)
#   print("starting")
#   for( i in 1:n){
#     word_list$score[i] = 
#       get_entropy(guess=words[i], n=n)
#     print(i)
#   }
#   print(word_list %>% top_n(5, score) %>% arrange(desc(score)))
# }