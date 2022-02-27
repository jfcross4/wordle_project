import time
import wordlist as wl

alphebet = [
  {"a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0, "i": 0, "j": 0, "k": 0, "l": 0, "m": 0, "n": 0, "o": 0, "p": 0, "q": 0, "r": 0, "s": 0, "t": 0, "u": 0, "v": 0, "w": 0, "x": 0, "y": 0, "z": 0},
  {"a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0, "i": 0, "j": 0, "k": 0, "l": 0, "m": 0, "n": 0, "o": 0, "p": 0, "q": 0, "r": 0, "s": 0, "t": 0, "u": 0, "v": 0, "w": 0, "x": 0, "y": 0, "z": 0},
  {"a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0, "i": 0, "j": 0, "k": 0, "l": 0, "m": 0, "n": 0, "o": 0, "p": 0, "q": 0, "r": 0, "s": 0, "t": 0, "u": 0, "v": 0, "w": 0, "x": 0, "y": 0, "z": 0},
  {"a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0, "i": 0, "j": 0, "k": 0, "l": 0, "m": 0, "n": 0, "o": 0, "p": 0, "q": 0, "r": 0, "s": 0, "t": 0, "u": 0, "v": 0, "w": 0, "x": 0, "y": 0, "z": 0},
  {"a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0, "i": 0, "j": 0, "k": 0, "l": 0, "m": 0, "n": 0, "o": 0, "p": 0, "q": 0, "r": 0, "s": 0, "t": 0, "u": 0, "v": 0, "w": 0, "x": 0, "y": 0, "z": 0}
]

def combine_and_count(list, accuracy = 2):
  long_positions = {0: "", 1: "", 2: "", 3: "", 4: ""}
  for i in list:
    for j in range(0, 5):
      long_positions[j] += i[j]
  for i in range(0, 5):
    for j in long_positions[i]:
      alphebet[i][j] += 1
  num_of_letters = 0
  for i in range(0, 5):
    num_of_letters += sum(alphebet[i].values())
  for i in range(0, 5):
    for j in alphebet[i]:
      alphebet[i][j] = round((alphebet[i][j] / num_of_letters) * 5, accuracy)
  return alphebet

value = combine_and_count(wl.all, 3)

def create_value_list_green():
  value_list_green = {}
  for i in wl.all:
    word_score = 0
    for j in range(0, 5):
      letter = i[j]
      word_score += value[j][letter]
    value_list_green[i] = round(word_score, 3)
  
  value_list_green = {k: v for k, v in sorted(value_list_green.items(), key=lambda item: item[1])}
  return value_list_green

create_value_list_green()



