require 'csv'

module FileWriter
  def self.write(filename, users)
  CSV.open(filename ,'wb',
      :write_headers=> true,
      :headers => ["USER ID","EMAIL","DASHBOARD", "REPORT BUILDER", "HEADLINE TESTING"] #< column header
      # :return_headers => true
    ) do|csv|
        users.each do |user|
          # binding.pry
          csv << [user.user_id, user.email, user.newsbeat.join(", "), user.report_builder.join(", "), user.headline_testing.join(", ")]
        end
      end
  end

end
