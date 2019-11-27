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

end
