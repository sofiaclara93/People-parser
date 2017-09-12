class Domain

  attr_reader :domain, :ids, :product
  attr_writer :domain, :ids, :product

  def initialize(args = {})
    @domain = args.fetch(:domain)
    @product = args.fetch(:product)
    @ids = args.fetch(:ids)
  end



end
