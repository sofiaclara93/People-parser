require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'io/console'

require 'pry'
require 'pry-byebug'

module UserScraper
  def self.scrape(user_session)
    agent = Mechanize.new
    # agent.pluggable_parser.pdf = Mechanize::FileSaver
    page = agent.get("https://chartbeat.com/signin")
    form = page.forms.first
    form.username = user_session.email
    form.password = user_session.password
    page = page.form.submit

    while page.forms[1].action != "/two-factor/verify" do
      puts "Incorrect email or password 🙁. Please try again."
      puts "Enter your Chartbeat email address please:"
      user_session.email = gets.chomp
      puts "Enter your password please:"
      user_session.password = STDIN.noecho(&:gets).chomp
      page.form.username = user_session.email
      page.form.password = user_session.password
      page = page.form.submit
    end

    verification_form = page.forms[1]
    if user_session.verification_code == ""
      puts "what is your verifcation code?"
      code = gets.chomp
      user_session.verification_code = code
    end
    verification_form.token = user_session.verification_code
    page = verification_form.submit
    # binding.pry
    puts "Please enter the Account ID:"
    uid = gets.chomp

    admin_page_url = "https://chartbeat.com/admin_nimda/account/view/#{uid}/"

    product_page_url = "https://chartbeat.com/admin_nimda/account/products/#{uid}/"

    user_session.admin_page_url = admin_page_url

    user_session.product_page_url = product_page_url

    page = agent.get(user_session.admin_page_url)

    data=[]
    i = 0
    page.at('table#userTable').search('tr').each do |tr|
      if i == 0
        i += 1
      else
        if tr.attributes["data-active"].value == "true"
          user_id = tr.attributes["data-userid"].value
          email = tr.attributes["data-email"].value
          hash = {user_id: user_id, email: email}
          data << User.new(hash)
        end
      end
    end
    return data
  end
end
