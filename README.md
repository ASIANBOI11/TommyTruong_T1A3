# Terminal Application Project [--Github Repo](https://github.com/ASIANBOI11/TommyTruong_T1A3)

## Implementation plan [--Trello Board](https://trello.com/b/ZXzlQFVY/budgeting-app)

---

### About my Application
Budgeting is a budgeting app that helps users keep track on their financial goal. It is run through the terminal and will take you to the main menu. This app will save and record your budgeting records in files so the user doesn't have to worry about lost data when the terminal is closed.

The application follows the ruby styling guide conventions which is linked [here](https://rubystyle.guide/)

---

### Installation
* The budgeting app must be downloaded throught the github repo.
* Once you've downloaded the repo, you'll have to unzip the file to release its content.
* Open up your terminal and change your root directory inside the repo or open the folder through an IDE that supports terminal commands.
* The application heavily uses gems so it is necessary to install bundler. In the terminal type up ```gem install bundler``` . Bundler allows the program to call mulitple necessary gems into the program. (This process can be skipped if you have bundler installed)
* After installing bundler through the terminal, run the command in the terminal ```./run_main.sh```. This will run the budgeting program.

---
### Features (Command Lines)
* ```./run_main.sh```  Running this command will load the application to the main menu.
* ```./run_main.sh -h``` Running this command will will load different types of command lines.
* ```./run_main.sh -i``` Running this command will give the user more information about the application and what it does.

---
### Feature (Main Menu)
The main menu display the options the user can take throughout the application. These are:
* Creating a new budget schedule
* Editing your previous made before budget schedule
* Deleting your previous made before budget schedule
* Reviewing your previous made before budget schedule
---
### Feature (Create)
* Creates a new budgeting schedule
* It saves your details on a json file so the user can access it even after closing the terminal
* It will record the day you started the budget, your budget limit in the time interval, your budget spent in the time interval and the date you want to end your budget as a goal.
---

### Feature (Editing)
* Edits your budget information such as changing the budget limit or budget spending.
* It can change the start and end dates of your budget.
---

### Feature (Deleting)
* This will delete your previously made budget out of existance. You won't be able to recover your deleted budget scheules once it's deleted.

---

### Feature (Reviewing)
* This will review your budget schedule and check if you are spending over the budget limit. If the user is spending over the budget limit, the program will give the user a message that it's spending over the limit however if it's not going over the limit, it will say it is under the budget limit.

---

### Testing
* Edit budget - This test ensure that the values are appropriatetly used correctly in the right context of the program. If a value that is invalid goes though this test, it will not pass through. I've done this test by using a validator of one of my gems and used regex to ensure that the expected values pass through the program.
* File Naming - File naming uses regex to make sure there aren't any white spaces when inputting a name into a budget. This allows no white spaces to be formed in a text or string value of naming a file.

---

### Dependecies
Ruby is essential for running this application. It functions through the use of the ruby language and gems. If you wish to use this program, you'll have to have ruby installed up to 3.1.1 version. You can download ruby [here.](https://www.ruby-lang.org/en/downloads/)

#### Gems used in the application

gem 'tty-prompt', '~> 0.23.1'

gem 'tty-font', '~> 0.5.0'

gem 'rspec', '~> 3.11'

gem 'json', '~> 2.6'

gem "rainbow", "~> 3.1"

gem "tty-table", "~> 0.12.0"

These gems are automatically installed into your system if you follow the installation guide at the top. You can find more gems for ruby [here.](https://rubygems.org/)

---
### Reference
[The ruby convention guide,](https://rubystyle.guide/) accessed in 2nd April 2022

[Terminal Apps the Easy Way,](https://ttytoolkit.org/) accessed in 29th March 2022