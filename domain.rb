require 'pry'
require 'pry-byebug'

class Domain

  attr_reader :domain, :ids
  attr_writer :domain, :ids

  def initialize(args = {})
    @domain = new_domain(args)
    @ids = new_ids(args.fetch(:ids))
  end

# sets domain as domain_product to differentiate btwn products
  def new_domain(args)
    domain = args.fetch(:domain).chomp("(adminfly)")
    product = args.fetch(:product)
    return new_domain = domain.delete(domain[-1]) + "_" + product
  end

  def new_ids(ids)
    ids_array = ids.split(/\W/)
    ids_array.each do |id|
      if id.length == 10 || id.length == 12
        ids_array.delete(id)
        binded_ids = id.chars.each_slice(id.length/2).map(&:join)
        ids_array= ids_array.push(binded_ids[0], binded_ids[1])
      elsif id.length == 11 && id[0].to_i == 9
        binded_ids = ids_array.delete(id)
        binded_ids = [binded_ids[0..4], binded_ids[5..10]]
        ids_array.push(binded_ids[0],binded_ids[1])
      elsif id.length == 11 && id[0].to_i == 1
        binded_ids = ids_array.delete(id)
        binded_ids = [binded_ids[0..5], binded_ids[6..10]]
        ids_array.push(binded_ids[0],binded_ids[1])
      else
        id
      end
    end
  end

end
