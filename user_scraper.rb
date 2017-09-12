require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

require 'pry'
require 'pry-byebug'

module UserScraper
  def self.scrape(user_session)
    agent = Mechanize.new
    # agent.pluggable_parser.pdf = Mechanize::FileSaver
    page = agent.get(user_session.admin_page_url)
    form = page.forms.first
    form.username = user_session.email
    form.password = user_session.password
    page = page.form.submit

    verification_form = page.forms[1]
    puts "what is your verifcation code?"
    code = gets.chomp
    user_session.verification_code = code
    verification_form.token = user_session.verification_code
    page = verification_form.submit
    page = agent.get(user_session.admin_page_url)

    data=[]
    i = 0
    page.at('table#userTable').search('tr').each do |tr|
      if i == 0
        i += 1
      else
        user_id = tr.children[1].text.chomp(" (adminfly)")
        email = tr.children[13].children[1].children.children.text
        hash = {user_id: user_id, email: email}
        data << User.new(hash)
      end
    end
    return data
  end
end
