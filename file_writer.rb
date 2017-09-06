require 'csv'

module FileWriter
  def self.write(users)
  CSV.open('user_permissions.csv','wb ',
      :write_headers=> true,
      :headers => ["user_id","email","newsbeat", "report_builder", "headline_testing"] #< column header
    ) do|csv|
      binding.pry
      end
  end

end



    #
    # # Saves the data for each person
    # # to the specified file.
    # CSV.open(filename,"wb") do |csv|
    #   people.each do |person|
    #     person.each do |human|
    #
    #       # binding.pry
    #       csv << human.csv_format.split(",")
    #     end
    #   end
    # end
