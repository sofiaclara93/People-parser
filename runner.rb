require_relative 'user_scraper'
require_relative 'user'
require_relative 'domain_scraper'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'
require_relative 'user_session'
require_relative 'file_path_creator'

require 'io/console'



puts "\nYou will need to sign in to Chartbeat. Please be ready to enter your two-factor verifcation code 😁 \n\n"

puts "Please enter your Chartbeat Email Address:"

email = gets.chomp

puts "Please enter your Password:"
password = STDIN.noecho(&:gets).chomp

user_session = UserSession.new(email, password)

users = UserScraper.scrape(user_session)

domains = DomainScraper.scrape(user_session)

updated_users = DomainChecker.check(users, domains)

puts "What would you like to call this csv file?"
filename = gets.chomp
filepath = FilePath.create(filename)


FileWriter.write(filepath, updated_users)
file = filepath.split("/").last
puts "\nThe File has been created as '#{file} and is located at #{filepath}'\n\n"
%x(open #{filepath})
