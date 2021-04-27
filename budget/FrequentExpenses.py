from collections import Counter

import matplotlib.pyplot as plt

from . import Expense

expenses = Expense.Expenses()

data = expenses.read_expenses(r'data/spending_data.csv')

spending_categories = []

for expense in expenses.list:
    spending_categories.append(expense.category)

spending_counter = Counter(spending_categories)
top5 = spending_counter.most_common(5)

categories, count = zip(*top5)

fig, ax = plt.subplots()
ax.bar(categories, count)
ax.set_title('# of Purchases by Category')

plt.show()