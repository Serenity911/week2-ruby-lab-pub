class Pub

attr_reader :name, :till


  def initialize(name, till, drinks_array = [] )
    @name = name
    @till = till
    @drinks = drinks_array
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


end
