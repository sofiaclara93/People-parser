require 'fileutils'

# finds file and copies and changes name
module FileCopier
  def self.find(filename)
    paths = []
    Dir["../**/*#{filename}"].each do |file|
      paths.push(File.absolute_path(file))
    end
    return paths[0]
  end

  def self.copy(filename)
    puts "copying file #{filename}..."
    FileUtils.cp find(filename) , "#{Dir.pwd}/emails.csv"
  end

end


require 'fileutils'

# finds file and copies and changes name
module FileCopier
  def self.find(filename)
    paths = []
    Dir["../**/*#{filename}"].each do |file|
      paths.push(File.absolute_path(file))
    end
    if paths.length === 0
      puts "File not found"
      # find way to break out of this without error
    elsif paths.length > 1
      puts "More than one path exists for this file. Please choose and paste the correct file path:\n"
      i = 1
      paths.each do |path|
        puts "#{i}. #{path}"
        i+= 1
      end
      # puts paths
      path = gets.chomp
      return path
    else
      return paths[0]
    end
  end

  def self.email_copy(filename)
    puts "Thanks 😁 \ncopying file '#{filename}'..."

    FileUtils.cp find(filename) , "#{Dir.pwd}/emails.csv"
    puts "Copy was successful 👍 "
  end

  def self.products_copy(filename)
    puts "Thanks 😁 \ncopying file '#{filename}'..."
    FileUtils.cp find(filename) , "#{Dir.pwd}/domains.csv"
    puts "Copy was successful 👍 "
  end
end
