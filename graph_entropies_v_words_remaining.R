word_scores = find_best_words(word_list)
write.csv(word_scores, file="word_scores.csv", row.names = FALSE)

word_entropy = find_best_words_entropy(word_list)
write.csv(word_entropy, file="word_entopies.csv", row.names = FALSE)

word_scores_plus = left_join(word_entropy, word_scores, by="word")

ggplot(word_scores_plus, aes(score.x, score.y)) + 
  geom_point(size=0.5, alpha=0.3, color="blue") + geom_smooth(color="red") + xlab("mean bits of information") + 
  ylab("mean words remaning")+
  ggtitle("Mean words remaining v. Mean bits of information")