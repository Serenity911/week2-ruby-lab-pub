class Customer

attr_reader :name, :wallet

  def initialize(name, wallet)
    @name = name
    @wallet = wallet
    @drinks = []
  end

  def check_money_for_drink(drink)
    return @wallet >= drink.price
  end

  def drink_counter()
    return @drinks.length
  end

  def increase_drink(drink)
    return @drinks.push(drink)
  end

  def decrease_wallet(drink)
    return @wallet -= drink.price
  end

end
