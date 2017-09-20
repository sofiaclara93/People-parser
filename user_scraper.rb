require 'nokogiri'
# require 'open-uri'
require 'mechanize'
require 'io/console'
require 'pry'
require 'pry-byebug'

module UserScraper

  def self.sign_in(user_session)
    agent = Mechanize.new
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

    verify_login(user_session, page)
    get_acct_id(user_session)
    page = agent.get(user_session.admin_page_url)

    until page.at('table#userTable') do
      puts "😱 We can't find this Account"
      get_acct_id(user_session)
      page = agent.get(user_session.admin_page_url)
    end
    return page
  end

  def self.verify_login(user_session, page)
    verification_form = page.forms[1]
    puts "what is your verifcation code?"
    code = gets.chomp
    user_session.verification_code = code
    verification_form.token = user_session.verification_code
    page = verification_form.submit


    if page.forms.length != 0
      # binding.pry
      puts "Incorrect verification code 🙁 , Please enter the correct code sent to you"
      verify_login(user_session, page)
    end

  end

  def self.get_acct_id(user_session)
    puts "Please enter the Account ID:"
    uid = gets.chomp

    user_session.admin_page_url = "https://chartbeat.com/admin_nimda/account/view/#{uid}/"

    user_session.product_page_url = "https://chartbeat.com/admin_nimda/account/products/#{uid}/"

    # page = agent.get(user_session.admin_page_url)
    # binding.pry
    # if page.at('table#userTable')
    #   return page
    # else
    #   puts "😱 We can't find this Account"
    #   get_acct_id(user_session)
    # end

  end

  def self.get_user_data(page, user_session)
    user_data=[]
    i = 0
    page.at('table#userTable').search('tr').each do |tr|
      if i == 0
        i += 1
      else
        if tr.attributes["data-active"].value == "true"
          user_id = tr.attributes["data-userid"].value
          email = tr.attributes["data-email"].value
          hash = {user_id: user_id, email: email}
          user_data << User.new(hash)
        end
      end
    end
    return user_data
  end

  def self.scrape(user_session)
    page = sign_in(user_session)
    # new_page = verify_login(user_session, page)
    # get_acct_id(user_session)
    get_user_data(page, user_session)

    # agent = Mechanize.new
    # page = agent.get("https://chartbeat.com/signin")
    # form = page.forms.first
    # form.username = user_session.email
    # form.password = user_session.password
    # page = page.form.submit
    #
    # while page.forms[1].action != "/two-factor/verify" do
    #   puts "Incorrect email or password 🙁. Please try again."
    #   puts "Enter your Chartbeat email address please:"
    #   user_session.email = gets.chomp
    #   puts "Enter your password please:"
    #   user_session.password = STDIN.noecho(&:gets).chomp
    #   page.form.username = user_session.email
    #   page.form.password = user_session.password
    #   page = page.form.submit
    # end

    # verification_form = page.forms[1]
    # puts "what is your verifcation code?"
    # code = gets.chomp
    # user_session.verification_code = code
    # verification_form.token = user_session.verification_code
    # page = verification_form.submit
    #
    # # until page.forms[1].action != "/two-factor/verify" do
    # while page.at('form.cb-two-factor-verify-form')
    #   puts "Incorrect verification code 🙁 , Please enter the correct code sent to you"
    #   verification_form = page.forms[1]
    #   code = gets.chomp
    #   user_session.verification_code = code
    #   verification_form.token = user_session.verification_code
    #   page = verification_form.submit
    # end


    # puts "Please enter the Account ID:"
    # uid = gets.chomp
    #
    # admin_page_url = "https://chartbeat.com/admin_nimda/account/view/#{uid}/"
    #
    # product_page_url = "https://chartbeat.com/admin_nimda/account/products/#{uid}/"
    #
    # user_session.admin_page_url = admin_page_url
    #
    # user_session.product_page_url = product_page_url

    # page = agent.get(user_session.admin_page_url)
    # if page.at('table#userTable')
    #   user_data=[]
    #   i = 0
    #   page.at('table#userTable').search('tr').each do |tr|
    #     if i == 0
    #       i += 1
    #     else
    #       if tr.attributes["data-active"].value == "true"
    #         user_id = tr.attributes["data-userid"].value
    #         email = tr.attributes["data-email"].value
    #         hash = {user_id: user_id, email: email}
    #         user_data << User.new(hash)
    #       end
    #     end
    #     return user_data
    #   end
    # else
    #   puts "We can't find this Account, please re-enter the Account ID:"
    # end

  end

end
