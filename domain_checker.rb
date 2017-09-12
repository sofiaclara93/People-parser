require 'pry'
require 'pry-byebug'
module DomainChecker
# checks if users is listed under domain permissions
# if user has permission user is updated
  def self.check(users, domains)
    users.map do |user|
      domains.each do |domain|
        if domain.ids.include? user.user_id
          if domain.product == "newsbeat"
            user.newsbeat.push(domain.domain)
          elsif domain.product == "queryapi"
            user.report_builder.push(domain.domain)
          elsif domain.product == "mab"
            user.headline_testing.push(domain.domain)
          end
        end
      end
    end
    # binding.pry
    return users
  end

end
