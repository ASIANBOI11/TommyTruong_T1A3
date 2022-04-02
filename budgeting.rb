require 'tty-prompt'
require 'tty-font'
require 'json'
require 'rainbow'

class Budgeting
  def main_menu
    @quit = false

    while @quit == false
      prompt = TTY::Prompt.new
      font = TTY::Font.new(:doom)
      puts font.write('                                             Budgeting   Application', letter_spacing: 0.5,
                                                                                              center: 1)
      user_input = prompt.select('Choose your available options',
                                 ['Create your budgeting schedule', 'Edit your budgeting schedule',
                                  'Delete your budgeting schedule',
                                  'Review your budget', 'Budget Savor', 'Quit'], cycle: true)
      case user_input
      when 'Create your budgeting schedule'
        system('clear')
        create_budget(budget_name_file)
      when 'Edit your budgeting schedule'
        edit_budget
      when 'Delete your budgeting schedule'
        puts 'Test'
      when 'Review your budget'
        puts 'People are testing'
      when 'Budget Savor'
        puts 'People are taking'
      when 'Quit'
        puts 'Quitting'
        system('clear')
        @quit = true
      end
    end
  end

  # Creates a budget json file through using the arguement of budget info.
  def create_budget(budget_info)
    @quit = true
    JSON.generate(budget_info)
    File.open("./Budget-Files/#{budget_info[:budget_name]}.json", 'w') do |file|
      file.write(budget_info.to_json)
    end
    puts Rainbow('A new budget file has been created').magenta
    @quit = false
  end

  def edit_budget
    @quit = true
    prompt = TTY::Prompt.new
    file_selection = prompt.select('Which budget file would you like to edit', file_choosen, cycle: true)
  end

  # The names of the budget files variables that is stored as a hash
  def budget_name_file
    prompt = TTY::Prompt.new
    budget_name = prompt.ask("What's the name of your newly created budget: ") do |q|
      q.modify :strip
      q.required true
    end

    budget_amount = prompt.ask('What is your budget limit for the time interval $') do |q|
      q.required true
      q.convert(:float, 'Please enter a number')
      q.validate(/^[+]?([.]\d+|\d+[.]?\d*)$/, 'Please enter a positive number')
    end

    budget_spent = prompt.ask("The amount you've spent during your budget time internval") do |q|
      q.required true
      q.convert(:float, 'Please enter a number')
      q.validate(/^[+]?([.]\d+|\d+[.]?\d*)$/, 'Please enter a positive number')
    end

    budget_date = prompt.ask('What is the date of your budget: ') do |q|
      q.required true
      q.validate(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})}, 'Please enter a valid date DD/MM/YYYY')
    end

    { budget_name: budget_name.to_s, budget_amount: budget_amount.to_s, budget_spent: budget_spent,
      budget_date: budget_date }
  end
end

def file_choosen
  budget_file = []
  file = Dir.children './Budget-Files'
  file.map! do |file|
    file = file.split('.DS_Store')
    budget_file << file
  end
  budget_file
end

budgeting = Budgeting.new
budgeting.main_menu
