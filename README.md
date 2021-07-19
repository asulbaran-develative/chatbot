# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.0.0

* Rails version 6.1.3

* System dependencies
  gem 'devise'
  gem 'figaro'
  gem 'aasm', '~> 4.11'
  gem 'wicked_pdf', '~> 1.1'
  gem 'wkhtmltopdf-binary'
  gem 'ftools' 

* Configuration
  - git clone https://github.com/asulbaran-develative/chatbot
    If you ruby version is'nt 3.0, you can install RVM: 
      - https://rvm.io/rvm/install
      - rvm install 3.0.0
  - bundle install   
  - apt-get install postgresql libpq-dev  (Optional)
  - sudo su postgres
  - psql postgres
  - CREATE ROLE chatbot WITH PASSWORD '123456' LOGIN CREATEDB ;
  - NodeJs is Required
  - install nvm ( https://github.com/nvm-sh/nvm )
  - nvm install node --stable
  - npm install -g yarn
  - execte "yarn" in proyect path 

* Database creation
  rake db:setup

* Database initialization
  rake db:migrate
  rake db seed

* Deployment instructions
  rails server -p 3000

* Usage: 
    English: When the page opens, select Sign up, add email and password or login and enter 
             email and password. You can start using the chatbot.
    Español: Cuando se abra la página, seleccione Registrarse, agregue correo electrónico y 
             contraseña o inicie sesión y escriba el correo electrónico y la contraseña.
             Puede comenzar a usar el chatbot.