class Pub

attr_reader :name, :till


  def initialize(name, till, drinks_array = [] )
    @name = name
    @till = till
    @drinks = drinks_array
    @minimum_age = 18
  end

  def drink_stock()
    return @drinks.length
  end

  def ask_customer_to_check_money(customer, drink)
    # if customer.check_money_for_drink(drink) == true
    #   return true
    # else
    #   return false
    # end
    return customer.check_money_for_drink(drink)
  end

  def reduce_drink_stock(drink)
    if @drinks.include?(drink)
      @drinks.delete(drink)
    end
  end

  def increase_till_by_price_of_drink(drink)
    @till += drink.price
  end

  def sell_a_drink(customer, drink)
    if @drinks.include?(drink)
      if check_minimum_age(customer)
        if ask_customer_to_check_money(customer, drink)
          reduce_drink_stock(drink)
          increase_till_by_price_of_drink(drink)
          customer.increase_drink(drink)
          customer.decrease_wallet(drink)
        end
      end
    end
  end

  def check_minimum_age(customer)
    return customer.age >= @minimum_age
  end


end
