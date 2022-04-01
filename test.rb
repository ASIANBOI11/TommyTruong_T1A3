def compare(budgetSpentWeek1, budgetSpentWeek2, budgetLimit)
  if budgetSpentWeek1 > budgetLimit || budgetSpentWeek2 > budgetLimit
    puts "You're spent over spending limit for both week 1 and week 2. Cut down your spending"
  elsif udgetSpentWeek1 < budgetLimit || budgetSpentWeek2 < budgetLimit
    puts "You're under the spending limit for both week 1 and week 2. You've got money saved up"
  end

  if budgetSpentWeek1 > budgetSpentWeek2
    puts "Congradulation, you've spent less on week 2 than week 1"
  elsif budgetSpentWeek1 < budgetSpentWeek2
    puts "You've spent more on week 2 than on week one"
  end
end

input1 = gets.chomp.to_f
input2 = gets.chomp.to_f
input3 = gets.chomp.to_f

compare(input1, input2, input3)
