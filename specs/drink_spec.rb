require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../drink')

class TestDrink < Minitest::Test

  def setup
    @drink = Drink.new("White Russian", 5, 14)
  end

  def test_get_drink_name
    assert_equal("White Russian", @drink.name)
  end

  def test_get_drink_price
    assert_equal(5, @drink.price)
  end

  def test_check_drink_has_alcohol_level
    assert_equal(14, @drink.alcohol_level)
  end

end
