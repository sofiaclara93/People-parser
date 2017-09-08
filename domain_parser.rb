require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

require 'pry'
require 'pry-byebug'


module DomainScraper
  def self.scrape
    agent = Mechanize.new
    # agent.pluggable_parser.pdf = Mechanize::FileSaver

    page = agent.get("https://chartbeat.com/admin_nimda/account/products/57773/")
    form = page.forms.first
    form.username = "sofia@chartbeat.com"
    form.password = "Mimi1553"
    page = form.submit

    verification_form = page.forms[2]
    puts "what is your verifcation code?"
    code = gets.chomp
    verification_form.token = code
    page = verification_form.submit
    page = agent.get("https://chartbeat.com/admin_nimda/account/products/57773/")

    data=[]
    i = 0
    page.at('table.domainTable').search('tr').each do |tr|
      if i == 0
        i += 1
      else
        domain = tr.children[1].text.chomp(" (adminfly)")
        product = tr.children[5].text
        uids = tr.children[7].children.text.tr_s("\n                            \n" , ",").split(",")
        uids.shift

        hash = {domain: domain, product: product, ids: uids}
        data << Domain.new(hash)
      end
    end
    return data
  end
end
