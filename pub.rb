require_relative('drink')
require_relative('food')

class Pub

attr_reader :name, :till


  def initialize(name, till, food, drinks_hash = {} )
    @name = name
    @till = till
    @drinks_stock = drinks_hash
    @minimum_age = 18
    @drunkeness_limit = 100
    @food = food
  end

  def total_drinks_stock()
    return @drinks_stock.values.inject(0){|sum,x| sum + x}
  end

  def drink_stock(drink)
    @drinks_stock[drink]
  end

  def ask_customer_to_check_money(customer, drink)
    return customer.check_money_for_drink(drink)
  end

  def has_drink(drink)
    if drink_stock(drink).nil?
      return false
    end
    drink_stock(drink) > 0
  end

  def reduce_drink_stock(drink)
    if !drink_stock(drink).nil? && drink_stock(drink) != 0
    @drinks_stock[drink] -= 1
    end
  end

  def increase_till_by_price_of_drink(drink)
    @till += drink.price
  end

  def sell_a_drink(customer, drink)
    if has_drink(drink)
      if check_minimum_age(customer)
        if check_customer_drunkennes(customer) <= @drunkeness_limit
          if ask_customer_to_check_money(customer, drink)
            reduce_drink_stock(drink)
            increase_till_by_price_of_drink(drink)
            customer.increase_drink(drink)
            customer.decrease_wallet(drink)
            customer.increase_drunkenness(drink)
          end
        end
      end
    end
  end

  def check_minimum_age(customer)
    return customer.age >= @minimum_age
  end

  def check_customer_drunkennes(customer)
    return customer.drunkenness
  end


end
