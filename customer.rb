class Customer

  attr_reader :name, :wallet, :age, :drunkenness

  def initialize(name, wallet, age)
    @name = name
    @wallet = wallet
    @age = age
    @drinks = []
    @drunkenness = 0
    @foods = []
  end

  def check_money_for_drink(drink)
    return @wallet >= drink.price
  end

  def check_money_for_food(food)
    return @wallet >= food.price
  end

  def drink_counter()
    return @drinks.length
  end

  def food_counter()
    return @foods.length
  end

  def increase_drink(drink)
    return @drinks.push(drink)
  end

  def increase_food(food)
    return @foods.push(food)
  end

  def decrease_wallet_after_buying_drink(drink)
    return @wallet -= drink.price
  end

  #TODO RUN THE TESTS
  def decrease_wallet_after_buying_food(food)
    return @wallet -= food.price
  end

  def increase_drunkenness(drink)
    return @drunkenness += drink.alcohol_level
  end

  def decrease_drunkenness(food)
    return @drunkenness -= food.rejuvenation_level
  end

end
