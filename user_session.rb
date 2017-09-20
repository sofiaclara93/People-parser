class UserSession

  attr_reader :email, :password, :admin_page_url, :product_page_url, :verification_code
  attr_writer :email, :password, :admin_page_url, :product_page_url, :verification_code

  def initialize(email, password)
    @email = email
    @password = password
    @admin_page_url = ""
    @product_page_url = ""
    @verification_code = ""
  end

end
