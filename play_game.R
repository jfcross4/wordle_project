game_results = 
  data.frame(actual_word=character(), 
             guess=numeric(), 
             guess_word=character(),
             words_remaining=numeric())

play_game <- function(actual_word, guess_word){
  game_on = TRUE
  updated_list = answers_list
  nguess = 1
  while(game_on){
    if(guess_word==actual_word){game_on=FALSE}
  result = evaluate_guess(actual_word, guess_word)
  result =paste0(result, collapse="")
  
  updated_list <- narrow_word_list(word_list=updated_list, 
                                   guess=guess_word, result=result,
                                   combo_list = combo_list)
  
  best_word = find_mean_bits_remaining(combo_list = combo_list, updated_list,
                           n_return=1)
  game_results = rbind(game_results, 
                       data.frame(actual_word=actual_word, 
                                  guess = nguess,
                                  guess_word=guess_word,
                                  words_remaining = length(updated_list$word)))
  
  guess_word = best_word$possible_guess[1]
  nguess = nguess + 1
  }
  return(game_results)
}
