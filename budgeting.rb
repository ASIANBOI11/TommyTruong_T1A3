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
      puts font.write('Budgeting   Application', letter_spacing: 0.5,
                                                 center: 1)
      user_input = prompt.select('Choose your available options',
                                 ['Create your budgeting schedule', 'Edit your budgeting schedule',
                                  'Delete your budgeting schedule',
                                  'Review your budget', 'Budget Savor', 'Quit'], cycle: true)
      case user_input
      when 'Create your budgeting schedule'
        system('clear')
        puts font.write('Budget Creation', letter_spacing: 0.5)
        create_budget(budget_name_file)
      when 'Edit your budgeting schedule'
        system('clear')
        edit_budget
      when 'Delete your budgeting schedule'
        puts font.write('Budget Delete', letter_spacing: 1)
        delete_budget
      when 'Review your budget'
        system('clear')
        puts font.write('Review Budget', letter_spacing: 0.5)
        review_budget
      when 'Budget Savor'
        puts 'People are taking'
      when 'Quit'
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
    puts Rainbow('Please go to review to see your budget information')
    @quit = false
  end

  def edit_budget
    @quit = true
    prompt = TTY::Prompt.new
    begin
      file_selection = prompt.select('Which budget file would you like to review', file_choosen, 'back', cycle: true)
      json_selection = JSON.parse(File.read("./Budget-Files/#{file_selection}"))

      edit_selection = prompt.select('Which one which you like to edit', 'The budget limit', 'The budget spent',
                                     'The start of the budget date', 'The end of the budget date')
      case edit_selection
      when 'The budget limit'
        puts Rainbow("Your current budget limit is #{json_selection['budget_amount']}")
        new_budget_amount = prompt.ask('Enter your new budget limit: $') do |q|
          q.required true
          q.convert(:float, 'Please enter a number')
          q.validate(/^[+]?([.]\d+|\d+[.]?\d*)$/, 'Please enter a positive number')
        end
        json_selection['budget_amount'] = new_budget_amount
        file_edit(file_selection, json_selection)
      when 'The budget spent'
        new_budget_spent = prompt.ask('Enter your new budget spent: $') do |q|
          q.required true
          q.convert(:float, 'Please enter a number')
          q.validate(/^[+]?([.]\d+|\d+[.]?\d*)$/, 'Please enter a positive number')
        end
        json_selection['budget_spent'] = new_budget_spent
        file_edit(file_selection, json_selection)
      when 'The start of the budget date'
        new_budget_start_date = prompt.ask('Enter your new start date: ') do |q|
          q.required true
          q.validate(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})}, 'Please enter a valid date DD/MM/YYYY')
        end
        json_selection['budget_date_end'] = new_budget_start_date
        file_edit(file_selection, json_selection)
      when 'The end of the budget date'
        new_budget_end_date = prompt.ask('Enter your new end date: ') do |q|
          q.required true
          q.validate(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})}, 'Please enter a valid date DD/MM/YYYY')
        end
        json_selection['budget_date_end'] = new_budget_end_date
        file_edit(file_selection, json_selection)
      end
    rescue StandardError
      puts Rainbow("You've created no existing budgeting schedules").magenta
    end
  end

  def file_edit(file_path, json_path)
    File.write("Budget-Files/#{file_path}", JSON.pretty_generate(json_path))
    puts Rainbow('Your details have been updated.').magenta
  end

  def delete_budget
    @quit = true
    prompt = TTY::Prompt.new
    begin
      file_selection = prompt.select('Which budget file would you like to edit', file_choosen, 'back', cycle: true)
      @quit = false if file_selection == 'back'
      File.delete("./Budget-Files/#{file_selection}")
      puts Rainbow("Budget #{file_selection.split('.').first} deleted").magenta
    rescue StandardError
      case @quit
      when true
        puts Rainbow("You've got no budgeting schedule to delete").magenta
      when false
        puts Rainbow("You've deleted nothing").magenta
      end
    end
    @quit = false
  end

  def review_budget
    @quit = true
    prompt = TTY::Prompt.new
    file_selection = prompt.select('Which budget file would you like to review', file_choosen, cycle: true)
    json_selection = JSON.parse(File.read("./Budget-Files/#{file_selection}"))

    puts Rainbow("Your budget name is #{json_selection['budget_name']}").yellow
    puts Rainbow("Your budget limit is $#{json_selection['budget_amount']}")
    puts Rainbow("The budget spent so far is $#{json_selection['budget_spent']}")
    puts Rainbow("This budget started at #{json_selection['budget_date_start']}")
    puts Rainbow("The budget ends at #{json_selection['budget_date_end']}")

    overbudget_stats(json_selection['budget_amount'], json_selection['budget_spent'])
    puts Rainbow('Go to budget savor to see if you can save some more money')
    @quit = false
  end

  def overbudget_stats(limit, spent)
    if spent > limit
      puts Rainbow("You are over the budget by $#{spent - limit}")
    else
      puts Rainbow("You are under budget by $#{limit - spent}")
    end
  end

  # The names of the budget files variables that is stored as a hash
  def budget_name_file
    prompt = TTY::Prompt.new
    budget_name = prompt.ask("What's the name of your newly created budget: ") do |q|
      q.modify :strip
      q.required true
      q.validate(/^\S+$/, "Please don't add add spaces for your budget name")
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

    budget_date_start = prompt.ask('What is the start date of your budget: ') do |q|
      q.required true
      q.validate(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})}, 'Please enter a valid date DD/MM/YYYY')
    end

    budget_date_end = prompt.ask('What is the end date of your budget: ') do |q|
      q.required true
      q.validate(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})}, 'Please enter a valid date DD/MM/YYYY')
    end

    { budget_name: budget_name.to_s, budget_amount: budget_amount, budget_spent: budget_spent,
      budget_date_start: budget_date_start, budget_date_end: budget_date_end }
  end
end

def number_requirements
  q.required true
  q.convert(:float, 'Please enter a number')
  q.validate(/^[+]?([.]\d+|\d+[.]?\d*)$/, 'Please enter a positive number')
end

def file_choosen
  budget_file = []
  file = Dir.children './Budget-Files'
  file.map do |q|
    file = q.split('.DS_Store')
    budget_file << file
  end
  budget_file
end

budgeting = Budgeting.new
budgeting.main_menu
