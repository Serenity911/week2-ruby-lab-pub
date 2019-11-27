require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer')
require_relative('../drink')
require_relative('../food')

class TestCustomer < Minitest::Test

  def setup
    @customer = Customer.new("Lauren", 1000, 18)
    @drink = Drink.new("Long Island Tea", 20, 18)
    @food = Food.new("pizza", 5, 20)
  end


  def test_get_customer_name
    assert_equal("Lauren", @customer.name)
  end

  def test_customer_wallet
    assert_equal(1000, @customer.wallet)
  end

  def test_customer_has_money_for_drink
    assert_equal(true, @customer.check_money_for_drink(@drink))
  end

  def test_customer_has_money_for_food
    assert_equal(true, @customer.check_money_for_food(@food))
  end


  def test_drink_counter_start_at_zero
    assert_equal(0, @customer.drink_counter)
  end

  def test_food_counter_start_at_zero
    assert_equal(0, @customer.food_counter)
  end

  def test_drink_array_has_increase_by_one_drink
    @customer.increase_drink(@drink)
    assert_equal(1, @customer.drink_counter)
  end

  def test_food_array_has_increase_by_food
    @customer.increase_food(@food)
    assert_equal(1, @customer.food_counter)
  end

  def test_customer_wallet_decreases_by_price_of_drink
    @customer.decrease_wallet_after_buying_drink(@drink)
    assert_equal(980, @customer.wallet)
  end

  def test_customer_wallet_decreases_by_price_of_food
    @customer.decrease_wallet_after_buying_food(@food)
    assert_equal(995, @customer.wallet)
  end

  def test_customer_age
    assert_equal(18, @customer.age)
  end

  def test_customer_drunkenness
    assert_equal(0, @customer.drunkenness)
  end

  def test_customer_drunkenness_increases_with_a_drink
    @customer.increase_drunkenness(@drink)
    assert_equal(18, @customer.drunkenness)
  end

  def test_customer_drunkenness_decrease_with_food
    @customer.increase_drunkenness(@drink)
    @customer.increase_drunkenness(@drink)
    @customer.decrease_drunkenness(@food)
    assert_equal(16, @customer.drunkenness)
  end


end
