get_avg_words_remaining_oldest = function(word_list, guess){
  word_table <- find_scores(word_list, guess)
  p = word_table/nrow(word_list)
  return(sum(p*word_table))
}

get_avg_words_remaining_old = function(combo_list, guess){
  word_table <- 
    combo_list %>% 
    filter(possible_guess == guess) %>% 
    dplyr::select(scoring) %>% table()
  p = word_table/nrow(word_list)
  return(sum(p*word_table))
}

get_avg_words_remaining2 = function(combo_list, guess){
  word_table <- 
    combo_list %>% 
    filter(possible_guess == guess) %>% 
    dplyr::select(scoring) %>% table()
  p = word_table/nrow(word_list)
  return(sum(p*word_table))
}

get_avg_words_remaining = 
  function(pos_guesses=filtered_list$possible_guess, 
            all_scoring=filtered_list$scoring, 
            guess,
           n = num_words_remaining){
  word_table = table(all_scoring[pos_guesses == guess])
  #return(word_table)
  p = word_table/n
  return(n*sum(p*p))
  }


get_entropy = 
  function(pos_guesses=filtered_list$possible_guess, 
           all_scoring=filtered_list$scoring, 
           guess,
           n = num_words_remaining){
    word_table = table(all_scoring[pos_guesses == guess])
    #return(word_table)
    p = word_table/n
    return(-1*sum(p*log(p, base=2)))
  }

# t = Sys.time()
# get_avg_words_remaining(guess="tares", n=2314)
# Sys.time()-t
# 0.3 seconds

# t = Sys.time()
# get_avg_words_remaining_oldest(word_list, "tares")
# Sys.time()-t
# 3 - 4 seconds

# t = Sys.time()
# get_avg_words_remaining_old(combo_list, "tares")
# Sys.time()-t
# 0.6 s