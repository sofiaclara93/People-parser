require 'fileutils'

# finds file and copies and changes name
module FileCopier
  def self.find(filename)
    path = ""
    Dir["../**/*#{filename}"].each do |file|
      path = File.absolute_path(file)
    end
    return path
  end

  def self.copy(filename)
    puts "copying file #{filename}..."
    FileUtils.cp find(filename) , "#{Dir.pwd}/emails.csv"
  end

end
