require_relative 'budgeting'

def start_budgeting
  budget = Budgeting.new
  budget.main_menu
end

def start_budget
  start_budgeting if ARGV.length.zero?
  case ARGV[0]
  when '-h'
  puts 'Enter ./run_main.sh to begin the budgeting app'
  puts 'Enter ./run_main.sh -i to get more information'
  puts 'Enter ./run.main.sh -c to create your budget file'
  when '-i'
  puts 'This is a budgeting app'
  puts 'You can make your own budgetingg schedules'
  puts 'You can edit your budgeting files'
  puts 'You can even delete and review your budgeting files in the application'
  end
end

start_budget


