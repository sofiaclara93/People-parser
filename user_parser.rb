require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


# module UserParser
#   def self.parse(filename)
#     users = []
#     CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
#       users << User.new(row.to_hash)
#     end
#     return users
#   end
# end



module UserScraper
  def self.scrape
    agent = Mechanize.new
    # agent.pluggable_parser.pdf = Mechanize::FileSaver

    page = agent.get("https://chartbeat.com/admin_nimda/account/view/57773/")
    form = page.forms.first
    form.username = "sofia@chartbeat.com"
    form.password = "Mimi1553"
    page = form.submit

    verification_form = page.forms[2]
    puts "what is your verifcation code?"
    code = gets.chomp
    verification_form.token = code
    page = verification_form.submit
    page = agent.get("https://chartbeat.com/admin_nimda/account/view/57773/")

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
