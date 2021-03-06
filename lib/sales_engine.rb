require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require 'csv'
class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :data
  def initialize(data)
    @data = data
    @items_collection = []
    @merchants_collection = []
    @invoice_collection = []
    @invoice_item_collection = []
    @customer_collection = []
    @transaction_collection = []
    @items          = ItemRepository.new(create_items)
    @merchants      = MerchantRepository.new(create_merchants)
    @invoices       = InvoiceRepository.new(create_invoices)
    @invoice_items  = InvoiceItemRepository.new(create_invoice_items)
    @transactions   = TransactionRepository.new(create_transactions)
    @customers      = CustomerRepository.new(create_customers)
    @analyst        = SalesAnalyst.new(@items, @merchants, @invoices, @transactions, @invoice_items, @customers)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def create_items
    item_data = CSV.open(data[:items], headers: true, header_converters: :symbol)
    item_data.each do |row|
      @items_collection << Item.new( {
               id: row[:id].to_i,
               name: row[:name].to_s,
               description: row[:description].to_s,
               unit_price: big_decimal_converter(row[:unit_price]),
               merchant_id: row[:merchant_id].to_i,
               created_at: row[:created_at].to_s,
               updated_at: row[:updated_at].to_s
                                      } )
    end
    @items_collection
  end

  def big_decimal_converter(price)
    significant_digits = price.to_s.length
    number = price.to_f / 100
    BigDecimal.new(number, significant_digits)
  end

  def create_merchants
    merchant_data = CSV.open(@data[:merchants], headers: true, header_converters: :symbol)
    merchant_data.each do |row|
      @merchants_collection << Merchant.new( {id: row[:id].to_i,
                                             name: "#{row[:name]}"} )
    end
    @merchants_collection
  end

  def create_invoices
    invoice_data = CSV.open(@data[:invoices], headers: true, header_converters: :symbol)
    invoice_data.each do |row|
      @invoice_collection << Invoice.new( {id: row[:id].to_i,
                                          customer_id: row[:customer_id].to_i,
                                          merchant_id: row[:merchant_id].to_i,
                                          status: row[:status].to_s,
                                          created_at: row[:created_at].to_s,
                                          updated_at: row[:updated_at].to_s
                                          } )
    end
    @invoice_collection
  end

  def create_invoice_items
    invoice_item_data = CSV.open(@data[:invoice_items], headers: true, header_converters: :symbol)
    invoice_item_data.each do |row|
      @invoice_item_collection << InvoiceItem.new( {id: row[:id].to_i,
                                                    item_id: row[:item_id].to_i,
                                                    invoice_id: row[:invoice_id].to_i,
                                                    quantity: row[:quantity].to_i,
                                                    unit_price: big_decimal_converter(row[:unit_price]),
                                                    created_at: row[:created_at].to_s,
                                                    updated_at: row[:updated_at].to_s
                                                    } )
    end
    @invoice_item_collection
  end

  def create_transactions
    transaction_data  = CSV.open(@data[:transactions], headers: true, header_converters: :symbol)
    transaction_data.each do |row|
      @transaction_collection << Transaction.new( {
            id: row[:id].to_i,
            invoice_id: row[:invoice_id].to_i,
            credit_card_number: row[:credit_card_number].to_s,
            credit_card_expiration_date: row[:credit_card_expiration_date].to_s,
            result: row[:result].to_sym,
            created_at: row[:created_at].to_s,
            updated_at: row[:updated_at].to_s
                                                  } )
    end
    @transaction_collection
  end

  def create_customers
    customer_data = CSV.open(@data[:customers], headers: true, header_converters: :symbol)
    customer_data.each do |row|
      @customer_collection << Customer.new( {
            id: row[:id].to_i,
            first_name: row[:first_name].to_s,
            last_name: row[:last_name].to_s,
            created_at: row[:created_at].to_s,
            updated_at: row[:updated_at].to_s
                                            } )
    end
    @customer_collection
  end
end
