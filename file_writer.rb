require 'csv'

module FileWriter
  def self.write(users)
  CSV.open('user_permissions.csv','wb',
      :write_headers=> true,
      :headers => ["user id","email","newsbeat", "report builder", "headline testing"] #< column header
      # :return_headers => true
    ) do|csv|
        users.each do |user|
          # binding.pry
          csv << [user.user_id, user.email, user.newsbeat.join(", "), user.report_builder.join(", "), user.headline_testing.join(", ")]
        end
      end
  end

end
