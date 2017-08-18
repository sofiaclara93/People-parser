require_relative 'user_parser'
require_relative 'user'
require 'pry'
require 'pry-byebug'


users = UserParser.parse('email.csv')
