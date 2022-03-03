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