require_relative 'user_parser'
require_relative 'user'
require_relative 'domain_parser'
require_relative 'domain'

require 'pry'
require 'pry-byebug'


users = UserParser.parse('email.csv')
domains = DomainParser.parse('domains.csv')


domains.each do |d|
  binding.pry
end
# def thing(domains)
# binding.pry
# end
#
# thing(domains)
