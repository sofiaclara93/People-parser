require 'csv'


module DomainParser
  def self.parse(filename)
    domains = []
    CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
      domains << Domain.new(row.to_hash)
    end
    return domains
  end
end
