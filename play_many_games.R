game_results = data.frame(actual_word=character(), 
                          guess=numeric(), guess_word=character())

play_list = answers_list$word[-c(1:500)]

play_many_games = function(play_list, guess_word){
  for(i in play_list){
    print(i)
    new_results = play_game(i, guess_word)
    game_results = rbind(game_results, new_results)
  }
  return(game_results)
}
# t = Sys.time()
# game_results = play_many_games(play_list, "soare")
# Sys.time()-t
# write.csv(game_results, file="game_results2.csv", row.names = FALSE)
# 
# game_results1 = read.csv("game_results1.csv")
# game_results2 = read.csv("game_results2.csv")
# game_results = rbind(game_results1, game_results2)
# write.csv(game_results, file="game_results.csv", row.names = FALSE)

game_results %>% group_by(actual_word) %>% 
  summarize(n=n()) %>% 
  ungroup() %>% ggplot(aes(n))+geom_bar()

num_guesses = game_results %>% 
  group_by(actual_word) %>% summarize(total=n())

game_results_plus = left_join(game_results, num_guesses, by="actual_word")
