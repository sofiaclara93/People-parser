require_relative 'user_scraper'
require_relative 'user'
require_relative 'domain_scraper'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'

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


  # users = UserParser.parse('emails.csv')
  users = UserScraper.scrape
  # domains = DomainScraper.scrape('domains.csv')
  domains = DomainScraper.scrape

  updated_users = DomainChecker.check(users , domains)

  FileWriter.write(updated_users)
  puts "\nThe File has been created as 'user_permissions.csv'\n\n"
  %x(open user_permissions.csv)
end
