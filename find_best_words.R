find_best_words = function(combo_list, word_list){
  possible_words = word_list$word
  num_words_remaining = length(possible_words)
  filtered_list = combo_list %>% 
    filter(possible_answer %in% possible_words)
  
  filtered_list %>% 
    group_by(possible_guess, scoring) %>% 
    summarize(n=n()) %>% 
    group_by(possible_guess) %>% 
    summarize(average_words_remaining = 
                sum(n*n)/num_words_remaining) %>% 
    top_n(5, desc(average_words_remaining)) %>%
    arrange(average_words_remaining)
}
####

find_mean_bits_remaining = 
  function(combo_list, word_list, n_return=5){
  possible_words = word_list$word
  num_words_remaining = length(possible_words)
  filtered_list = combo_list %>% 
    filter(possible_answer %in% possible_words)
  
  results = filtered_list %>% 
    group_by(possible_guess, scoring) %>% 
    summarize(n=n(), .groups = 'drop') %>% 
    group_by(possible_guess) %>% 
    summarize(mean_bits_remaining = 
                sum(n*log(n, base=2))/num_words_remaining, .groups = 'drop') %>%
    mutate(guesses_remaining = 
             guesses_remaining(mean_bits_remaining),
           in_list = possible_guess %in% possible_words,
           score = ifelse(in_list, (1 - 1/num_words_remaining)*guesses_remaining,
                  guesses_remaining)) 
  
    return(results %>% top_n(n_return, desc(score)) %>% arrange(score) %>% 
             dplyr::select(possible_guess, mean_bits_remaining, score))
}

