require 'tty-prompt'
require 'tty-font'
require 'json'

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
        puts 'testingtesting'
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
    JSON.generate(budget_info)
    File.open("./Budget-Files/#{budget_info[:budget_name]}.json", 'w') do |file|
      file.write(budget_info.to_json)
      @quit = true
    end
  end

  # The names of the budget files variables that is stored as a hash
  def budget_name_file
    prompt = TTY::Prompt.new
    budget_name = prompt.ask("What's the name of your newly created budget: ") do |name|
      name.modify :strip
      name.required true
    end

    budget_amount = prompt.ask('What is your budget limit for the interval $') do |budget|
      budget.required true
      budget.convert(:float, 'Please enter a number')
    end

    { budget_name: budget_name.to_s, budget_amount: budget_amount.to_s }
  end

end

budgeting = Budgeting.new
budgeting.main_menu
