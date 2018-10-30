require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'mathn'
require 'date'
class SalesAnalyst
  attr_reader     :items, :merchants, :invoices, :transactions
  def initialize(items, merchants, invoices, transactions)
    @items      = items
    @merchants  = merchants
    @invoices = invoices
    @transactions = transactions
  end

  def count_all_items
    @items.all.count.round(2)
  end

  def count_all_merchants
    @merchants.all.count.round(2)
  end

  def average_items_per_merchant
    (count_all_items / count_all_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    counts = []
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      counts << (y.count - avg).to_f
    end
    sum = 0.00
    squares = counts.map do |num|
      num * num
    end
    squares.each do |square|
      sum += square
    end
    (Math.sqrt(sum / (count_all_merchants - 1))).round(2)
  end

  def merchants_with_high_item_count
    count = []
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      if y.count >= 7
        count << @merchants.find_by_id(x)
      end
    end
    count
  end

  def average_item_price_for_merchant(id)
    item_array = @items.find_all_by_merchant_id(id)
    prices = item_array.map do |item|
      item.unit_price_to_dollars
    end
    accumulator = 0
    prices.each do |price|
      accumulator += price
    end
    number = (accumulator / prices.length).round(2)
    significant_digits = number.to_s.length
    BigDecimal.new(number, significant_digits)
  end

  def average_average_price_per_merchant
    price_array = @merchants.all.map do |merchant|
      x = merchant.id
      average_item_price_for_merchant(x)
    end
    accumulator = 0
    price_array.each do |price|
      accumulator += price
    end
    (accumulator / (price_array.length)).round(2)
  end

  def price_average
    avg_items = 0
      avg = @items.all.map do |item|
          avg_items += item.unit_price_to_dollars
      end
      avg_items / avg.length
  end

  def price_standard_deviation
    average = price_average
    diff_array = @items.all.map do |item|
      difference = item.unit_price_to_dollars - average
      difference * difference
    end
    accumulator = 0
    diff_array.each do |diff|
    accumulator += diff
    end
    Math.sqrt(accumulator / diff_array.length).round(2)
  end

  def golden_items
    standard_dev = price_standard_deviation
    average_price = price_average
    @items.all.find_all do |item|
      (item.unit_price_to_dollars - average_price) > (standard_dev * 2)
    end
  end

  def average_invoices_per_merchant
    (count_all_invoices / count_all_merchants).round(2)
  end

  def count_all_invoices
    @invoices.all.count.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    counts = []
    @merchants.all.map do |merchant|
      x = merchant.id
      y = invoices.find_all_by_merchant_id(x)
      counts << (y.count - avg).to_f
    end
    sum = 0.00
    squares = counts.map do |num|
      num * num
    end
    squares.each do |square|
      sum += square
    end
    Math.sqrt(sum / (count_all_merchants - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    standard_dev = average_invoices_per_merchant_standard_deviation
    average_invoice_count = average_invoices_per_merchant
    @merchants.all.find_all do |merchant|
      id = merchant.id
      counter = @invoices.find_all_by_merchant_id(id)
      (counter.count - average_invoice_count) > (standard_dev * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    standard_dev = average_invoices_per_merchant_standard_deviation
    average_invoice_count = average_invoices_per_merchant
    doubled_standard_dev = standard_dev * 2
    @merchants.all.find_all do |merchant|
      id = merchant.id
      counter = @invoices.find_all_by_merchant_id(id)
      counter.count < (average_invoice_count - doubled_standard_dev)
    end
  end

  def date_to_days(date)
    days = { 1 => 'Monday',
             2 => 'Tuesday',
             3 => 'Wednesday',
             4 => 'Thursday',
             5 => 'Friday',
             6 => 'Saturday',
             7 => 'Sunday' }
    day = Date.parse(date).cwday
    days[day]
  end

  def average_days
    (@invoices.all.count.to_f / 7.00).round(2)
  end

  def total_days
    days_count = { 'Monday'     => 0,
                   'Tuesday'    => 0,
                   'Wednesday'  => 0,
                   'Thursday'   => 0,
                   'Friday'     => 0,
                   'Saturday'   => 0,
                   'Sunday'     => 0 }
    @invoices.all.map do |invoice|
      day = date_to_days(invoice.created_at.to_s)
      days_count[day] += 1
    end
    days_count
  end

  def invoice_days_standard_deviation
    average = average_days
    differences = total_days.map do |day, value|
      diff = (value - average)
      diff * diff
    end
    total = 0
    differences.each do |num|
      total += num
    end
    Math.sqrt(total / 6).round(2)
  end

  def top_days_by_invoice_count
    top_days = total_days.map do |day, value|
      if total_days[day] - invoice_days_standard_deviation > average_days
        total_days.key(value)
      end
    end
    top_days.delete_if { |day|  day == nil }
  end

  def invoice_status(status)
    status_count = { pending: 0,
                     shipped: 0,
                     returned: 0 }
    @invoices.all.map do |invoice|
      if invoice.status == status
        status_count[status] += 1
      end
    end
    ((status_count[status].to_f / @invoices.all.count) * 100.00).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions.all.any? do |transaction|
      transaction.invoice_id == invoice_id && transaction.result == :success
    end
  end
end
