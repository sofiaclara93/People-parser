require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

require 'pry'
require 'pry-byebug'


module DomainScraper
  def self.scrape
    agent = Mechanize.new

    page = agent.get("https://chartbeat.com/admin_nimda/account/products/57773/")
    form = page.forms.first
    form.username = "sofia@chartbeat.com"
    form.password = "Mimi1553"
    page = form.submit

    verification_form = page.forms[2]
    puts "what is your verifcation code?"
    code = gets.chomp
    # binding.pry
    verification_form.token = code
    page = verification_form.submit
    page = agent.get("https://chartbeat.com/admin_nimda/account/products/57773/")

    domains=[]
    i = 0
    # binding.pry
    page.at('table.domainTable').search('tr').each do |tr|
      if i == 0
        i += 1
      else
        # binding.pry
        domain = tr.children[1].text.chomp(" (adminfly)")
        product = tr.children[5].text
        uids = tr.children[7].children.text.tr_s("\n                            \n" , ",").split(",")
        uids.shift

        hash = {domain: domain, product: product, ids: uids}
        domains << Domain.new(hash)
      end
    end
    return domains
  end
end
