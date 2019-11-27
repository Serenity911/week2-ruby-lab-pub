class Customer

attr_reader :name, :wallet, :age, :drunkenness

  def initialize(name, wallet, age)
    @name = name
    @wallet = wallet
    @age = age
    @drinks = []
    @drunkenness = 0 
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

  def increase_drunkenness(drink)
    return @drunkenness += drink.alcohol_level
  end

  def decrease_drunkenness(food)
    return @drunkenness -= food.rejuvenation_level
  end

end
