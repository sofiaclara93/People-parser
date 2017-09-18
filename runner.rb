require_relative 'user_scraper'
require_relative 'user'
require_relative 'domain_scraper'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'
require_relative 'user_session'

require 'io/console'

puts "You will need to sign in to Chartbeat. Please be ready to enter your two-factor verifcation code 😁"

while true
  
  puts "Please enter your Chartbeat email address or enter 'quit':"

  email = gets.chomp
  if email === 'quit'
    break
  end

  # FileCopier.email_copy(emails_answer)
  # puts "\nPlease enter the filename containing the products list or 'quit':"
  #
  # products_answer =gets.chomp
  # if products_answer === 'quit'
  #   break
  # end

  # FileCopier.products_copy(products_answer)


  puts "Please enter your password or enter 'quit':"
  password = STDIN.noecho(&:gets).chomp
  if password === 'quit'
    break
  end


  puts "Please paste the URL for the 'Account' page in Admin or enter 'quit':"
  admin_page_url = gets.chomp
  if admin_page_url === 'quit'
    break
  end

  puts "Please paste the URL for the 'Product' page in Admin or enter 'quit':"
  product_page_url = gets.chomp
  if product_page_url === 'quit'
    break
  end

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
