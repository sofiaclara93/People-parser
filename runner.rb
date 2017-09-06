require_relative 'user_parser'
require_relative 'user'
require_relative 'domain_parser'
require_relative 'domain'
require_relative 'domain_checker'
require_relative 'file_writer'

require 'pry'
require 'pry-byebug'


users = UserParser.parse('email.csv')
domains = DomainParser.parse('domains.csv')

updated_users = DomainChecker.check(users , domains)

FileWriter.write(updated_users)
