require 'pry'
require 'pry-byebug'

class Domain

  def initialize(args = {})
    @domain = new_domain(args)
    @ids = new_ids(args.fetch(:ids))
  end

  def new_domain(args)
    domain = args.fetch(:domain).chomp("(adminfly)")
    product = args.fetch(:product)
    return new_domain = domain.delete(domain[-1]) + "_" + product
  end

  def new_ids(ids)
    binding.pry
  end
end
