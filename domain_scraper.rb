require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

require 'pry'
require 'pry-byebug'


module DomainScraper
  def self.scrape(user_session)
    agent = Mechanize.new

    page = agent.get(user_session.product_page_url)
    form = page.forms.first
    form.username = user_session.email
    form.password = user_session.password
    page = form.submit

    verification_form = page.forms[1]
    verification_form.token = user_session.verification_code
    page = verification_form.submit
    page = agent.get(user_session.product_page_url)

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

    i = 0
    page.xpath('/html/body/div/div/table[3]').search('tr').each do |tr|
      if i == 0
        i += 1
      else
        domain = tr.children[1].text.chomp(" (adminfly)")
        product = tr.children[9].text
        uids = tr.children[11].children.text.tr_s("\n                            \n" , ",").split(",")
        uids.shift

        hash = {domain: domain, product: product, ids: uids}
        domains << Domain.new(hash)
      end
    end
    return domains
  end
end
