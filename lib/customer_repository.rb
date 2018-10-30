require_relative '../lib/find_methods'
require_relative '../lib/customer'
require 'time'
class CustomerRepository
  include FindMethods
  def initialize(customers)
    @collection = customers
  end

  def find_all_by_first_name(f_name)
    @collection.find_all do |customer|
      customer.first_name == f_name
    end
  end

  def find_all_by_last_name(l_name)
    @collection.find_all do |customer|
      customer.last_name == l_name
    end
  end

  def create(attributes)
    highest = @collection.max_by do |transaction|
      transaction.id.to_i
    end
    new_id = highest.id.to_i + 1
    new_object = Customer.new( {
                    id: new_id,
                    first_name: attributes[:first_name].to_i,
                    last_name: attributes[:last_name].to_i,
                    created_at: Time.now.to_s,
                    updated_at: Time.now.to_s
                                } )
    @collection << new_object
    new_object
  end

  def update(id, attributes)
    being_updated = find_by_id(id)
    if being_updated
      if attributes.key?(:first_name)
        being_updated.first_name = attributes[:first_name]
      end
      if attributes.key?(:last_name)
        being_updated.last_name = attributes[:last_name]
      end
    end
  end
end
