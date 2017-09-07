require_relative 'user_parser'
require_relative 'user'
require_relative 'domain_parser'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'
require_relative 'file_copier'

require 'pry'
require 'pry-byebug'

# while true

  puts "Please enter the filename containing the emails or 'quit'"

  emails_answer = gets.chomp
  # if emails_answer === 'quit'
  #   break
  # end
  #
  FileCopier.copy(emails_answer)

  # users = UserParser.parse('emails.csv')
  # domains = DomainParser.parse('domains.csv')
  #
  # updated_users = DomainChecker.check(users , domains)
  #
  # FileWriter.write(updated_users)


# end
