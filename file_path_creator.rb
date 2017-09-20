module FilePath

  def self.create(filename)
    current_directory = Dir.pwd
    setPath(current_directory, filename)
  end

  def self.setPath(current_directory,filename)
    dir_array = current_directory.split('/')
    test_file_path = "/#{dir_array[1]}/#{dir_array[2]}/Downloads/#{filename}.csv"
    check(test_file_path)
  end

  def self.check(filepath)
    case File.exists? File.expand_path(filepath)
      when true
        puts "This file already exists. Choose another name:"
        filename = gets.chomp
        create(filename)
      else
        return filepath
    end

  end

end
