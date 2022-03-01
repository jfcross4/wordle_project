score_guess_answer_combos <- function(word_list, answers_list){
  # create evaluation data
  combo_list = 
    expand.grid(word_list$word, answers_list$answer)
  
  colnames(combo_list) = 
    c("possible_guess", "possible_answer")
  
  combo_list$scoring <- NA
  
  possible_answers = combo_list$possible_answer
  possible_guesses = combo_list$possible_guess
  scores = combo_list$scoring
  
  for (i in 1:length(scores)){
    scores[i] = 
      to_word(evaluate_guess(actual=possible_answers[i], 
                             guess = possible_guesses[i]))
    if(i %% 10000 == 0){print(i)}
  }
  
  combo_list$scoring = scores
  return(combo_list)
}

#fwrite(combo_list, file="combo_list.csv", row.names=FALSE)

