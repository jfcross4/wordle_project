import matplotlib.pyplot as plt
from green_freq import create_value_list_green
from yellow_freq import create_value_list_yellow

greens = create_value_list_green()
yellows = create_value_list_yellow()

greens = dict(sorted(greens.items()))
yellows = dict(sorted(yellows.items()))

green_nums = greens.values()
yellow_nums = yellows.values()

plt.scatter(green_nums, yellow_nums)
plt.savefig("green_yellow_plot")

print(green_nums)
