require_relative 'user_scraper'
require_relative 'user'
require_relative 'domain_scraper'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'
require_relative 'user_session'

require 'io/console'

puts "You will need to sign in to Chartbeat. Please be ready to enter your two-factor verifcation code 😁"

puts "Please enter your Chartbeat email address or enter 'quit':"

email = gets.chomp

puts "Please enter your password or enter 'quit':"
password = STDIN.noecho(&:gets).chomp

  user_session = UserSession.new(email, password)

while true
  # binding.pry
  # puts "Please enter the Account ID or enter 'quit':"
  # uid = gets.chomp
  # if uid == 'quit'
  #   break
  # end
  #
  # admin_page_url = "https://chartbeat.com/admin_nimda/account/view/#{uid}/"
  #
  # product_page_url = "https://chartbeat.com/admin_nimda/account/products/#{uid}/"
  #
  # user_session.admin_page_url = admin_page_url
  #
  # user_session.product_page_url = product_page_url


  # users = UserParser.parse('emails.csv')
  users = UserScraper.scrape(user_session)

  # domains = DomainScraper.scrape('domains.csv')
  domains = DomainScraper.scrape(user_session)

  updated_users = DomainChecker.check(users , domains)

  FileWriter.write(updated_users)
  puts "\nThe File has been created as 'user_permissions.csv'\n\n"
  %x(open user_permissions.csv)

end
