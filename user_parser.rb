require 'csv'


module UserParser
  def self.parse(filename)
    users = []
    CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
      users << User.new(row.to_hash)
    end
    return users
  end
end
