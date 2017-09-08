require_relative 'user_scraper'
require_relative 'user'
require_relative 'domain_scraper'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'
require_relative 'user_session'

require 'io/console'
require 'pry'
require 'pry-byebug'

while true

  # puts "Please enter the filename containing the emails or 'quit':"
  #
  # emails_answer = gets.chomp
  # if emails_answer === 'quit'
  #   break
  # end

  # FileCopier.email_copy(emails_answer)
  # puts "\nPlease enter the filename containing the products list or 'quit':"
  #
  # products_answer =gets.chomp
  # if products_answer === 'quit'
  #   break
  # end

  # FileCopier.products_copy(products_answer)

  puts "Username:"
  email = gets.chomp

  puts "Password:"
  password = STDIN.noecho(&:gets).chomp

  puts "Admin account page path:"

  admin_page_url = gets.chomp

  puts "Products page path:"

  product_page_url = gets.chomp

  user_session = UserSession.new(email, password, admin_page_url, product_page_url)

  # users = UserParser.parse('emails.csv')
  users = UserScraper.scrape(user_session)
  # domains = DomainScraper.scrape('domains.csv')
  domains = DomainScraper.scrape(user_session)

  updated_users = DomainChecker.check(users , domains)

  FileWriter.write(updated_users)
  puts "\nThe File has been created as 'user_permissions.csv'\n\n"
  %x(open user_permissions.csv)
end
