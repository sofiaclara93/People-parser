class User
  attr_reader :user_id, :email, :newsbeat, :report_builder, :headline_testing
  attr_writer :newsbeat, :report_builder, :headline_testing

  def initialize(args = {})
    @user_id = args.fetch(:user_id)
    @email = args.fetch(:email)
    @newsbeat = []
    @report_builder = []
    @headline_testing = []
  end

# FINISH LATER TO FORMAT PUSHING TO CSV WRITER FILE
  # def csv_format
  #   return "#{self.user_id},#{self.email},#{self.newsbeat},#{self.report_builder},#{self.headline_testing}"
  # end

end
