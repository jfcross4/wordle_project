# narrow_word_list_old <- function(word_list, guess, result){
#   guess = to_vector(guess)
#   result = to_vector(result)
#   words = word_list$word
#   new_word_list = c()
#   n = 0
#   for( i in 1:length(words)){
#     score <- evaluate_guess(guess=guess, actual=to_vector(words[i]))
#     if(identical(score, result)){
#       new_word_list = c(new_word_list, as.character(words[i]))}
#   }
#   return(new_word_list = data.frame(words=new_word_list))
# }


narrow_word_list <- function(word_list, guess, result, 
                             combo_list=combo_list){
  words = word_list$word
  filtered_list = combo_list %>% 
    filter(possible_guess==guess, scoring==result, 
           possible_answer %in% words)
  new_words = unique(filtered_list$possible_answer)
  return(new_word_list = data.frame(word=new_words))
}


