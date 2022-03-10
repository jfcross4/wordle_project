plot_information <- 
  function(guesses, combo_list=combo_list, word_list=word_list){
    possible_words = word_list$word
    num_words_remaining = length(possible_words)
    filtered_list = combo_list %>% 
      filter(possible_answer %in% possible_words)
    
    temp = filtered_list %>%  filter(possible_guess %in% guesses) %>%
      group_by(possible_guess, scoring) %>% 
      summarize(subn=n()) %>% 
      mutate(score = log(2314, base=2)-1*log(subn, base=2)) %>%
      group_by(possible_guess, subn) %>%
      summarize(n = sum(subn), prob = n/2314, score=first(score)) %>%
      arrange(score) %>% ungroup()
    
    ggplot(temp, aes(score, prob, col=possible_guess))+
      geom_col(lwd=2)+xlab("Information Revealed")+ylab("Probability")+
      ggtitle(paste("Prob v. Info Plot")) + facet_wrap(~possible_guess)
  }
  