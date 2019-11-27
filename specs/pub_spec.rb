require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../pub')
require_relative('../drink')
require_relative('../customer')
require_relative('../food')

class TestPub < Minitest::Test

  def setup
    @drink1 = Drink.new("Cosmopolitan", 10, 16)
    @drink2 = Drink.new("Tennants", 6, 10)
    @drink4 = Drink.new("The Satan Circus", 10, 90)
    @food1 = Food.new("pizza", 5, 20)
    @food2 = Food.new("chips", 3, 5)
    @pub = Pub.new("CodePub", 0, {@food1 => 10, @food2 => 0}, {@drink1 => 3, @drink2 => 0, @drink4 => 1})
    @customer1 = Customer.new("SiggyDaMan", 100, 100)
    @customer2 = Customer.new("Silvia", 1, 18)
    @customer3 = Customer.new("LittleJimmy", 50, 10)
  end

  def test_pub_has_a_name
    assert_equal("CodePub", @pub.name)
  end

  def test_pub_starts_with_till_empty
    assert_equal(0, @pub.till)
  end

  def test_pub_drink_counter_starts_with_four_stocks
    assert_equal(4, @pub.total_drinks_stock)
  end

  def test_pub_starts_with_stock_ten
    assert_equal(10, @pub.total_foods_stock)
  end

  def test_check_pub_has_a_drink
    check_has_drink = @pub.has_drink(@drink1)
    assert_equal(true, check_has_drink)
  end

  def test_check_pub_has_specific_food
    check_has_food= @pub.has_food(@food1)
    assert_equal(true, check_has_food)
  end

  def test_check_pub_does_not_have_a_drink
    check_has_drink = @pub.has_drink(@drink3)
    assert_equal(false, check_has_drink)
  end

  def test_check_pub_does_not_have_specific_food
    check_has_food= @pub.has_food(@food3)
    assert_equal(false, check_has_food)
  end

  def test_ask_customer_to_check_if_they_have_enough_money_for_a_drink
    assert_equal(true, @pub.ask_customer_to_check_money_for_drink(@customer1, @drink1))
    assert_equal(false, @pub.ask_customer_to_check_money_for_drink(@customer2, @drink1))
  end

  def test_ask_customer_to_check_if_they_have_enough_money_for_food
    assert_equal(true, @pub.ask_customer_to_check_money_for_food(@customer1, @food1))
    assert_equal(false, @pub.ask_customer_to_check_money_for_food(@customer2, @food1))
  end

  def test_drink_stock_reduces_by_one
    @pub.reduce_drink_stock(@drink1)
    assert_equal(2, @pub.drink_stock(@drink1))
  end

  def test_food_stock_reduces_by_one
    @pub.reduce_food_stock(@food1)
    assert_equal(9, @pub.food_stock(@food1))
  end

  def test_drink_stock_do_not_reduce_if_drink_not_found
    @pub.reduce_drink_stock(@drink3)
    assert_nil(@pub.drink_stock(@drink3))
  end

  def test_food_stock_do_not_reduce_if_food_not_found
    @pub.reduce_food_stock(@food3)
    assert_nil(@pub.food_stock(@food3))
  end

  def test_drink_stock_do_not_reduce_if_drink_stock_zero
    @pub.reduce_drink_stock(@drink2)
    assert_equal(0, @pub.drink_stock(@drink2))
  end

  def test_food_stock_do_not_reduce_if_food_stock_zero
    @pub.reduce_food_stock(@food2)
    assert_equal(0, @pub.food_stock(@food2))
  end

  def test_till_increases_by_price_of_drink
    @pub.increase_till_by_price_of_drink(@drink1)
    assert_equal(10, @pub.till)
  end

  def test_till_increases_by_price_of_food
    @pub.increase_till_by_price_of_food(@food1)
    assert_equal(5, @pub.till)
  end

  #tests for selling a drink
  def test_sell_a_drink
    @pub.sell_a_drink(@customer1, @drink1)
    assert_equal(2, @pub.drink_stock(@drink1))
    assert_equal(10, @pub.till)
    assert_equal(1, @customer1.drink_counter)
    assert_equal(90, @customer1.wallet)
  end

  def test_do_not_sell_drink_if_not_in_stock
    @pub.sell_a_drink(@customer1, @drink3)
    assert_equal(false, @pub.has_drink(@drink3))
    assert_equal(0, @pub.till)
    assert_equal(0, @customer1.drink_counter)
    assert_equal(100, @customer1.wallet)
  end

  def test_do_not_sell_drink_if_customer_has_not_enough_money
    @pub.sell_a_drink(@customer2, @drink1)
    assert_equal(3, @pub.drink_stock(@drink1))
    assert_equal(0, @pub.till)
    assert_equal(0, @customer2.drink_counter)
    assert_equal(1, @customer2.wallet)
  end

  def test_do_not_sell_drink_if_customer_is_not_old_enough
    @pub.sell_a_drink(@customer3, @drink1)
    assert_equal(3, @pub.drink_stock(@drink1))
    assert_equal(0, @pub.till)
    assert_equal(0, @customer3.drink_counter)
    assert_equal(50, @customer3.wallet)
  end

  def test_sell_drink_if_customer_is_old_enough
    @pub.sell_a_drink(@customer1, @drink1)
    assert_equal(2, @pub.drink_stock(@drink1))
    assert_equal(10, @pub.till)
    assert_equal(1, @customer1.drink_counter)
    assert_equal(90, @customer1.wallet)
  end

  def test_customer_is_old_enough_to_drink
    customer_old_enough = @pub.check_minimum_age(@customer1)
    assert_equal(true, customer_old_enough)
  end
  #
  def test_customer_is_old_enough_to_drink
    customer_not_old_enough = @pub.check_minimum_age(@customer3)
    assert_equal(false, customer_not_old_enough)
  end

  def test_check_customer_drunkenness_starts_at_zero
    customer_drunkenness = @pub.check_customer_drunkennes(@customer1)
    assert_equal(0, customer_drunkenness)
  end

  def test_pub_do_not_sell_if_customer_is_drunk
    @pub.sell_a_drink(@customer1, @drink4)
    @pub.sell_a_drink(@customer1, @drink1)
    @pub.sell_a_drink(@customer1, @drink2)
    assert_equal(2, @pub.drink_stock(@drink1))
    assert_equal(0, @pub.drink_stock(@drink4))
    assert_equal(20, @pub.till)
    assert_equal(2, @customer1.drink_counter)
    assert_equal(80, @customer1.wallet)
  end

  def test_customer_drunkenness_after_one_drink
    @pub.sell_a_drink(@customer1, @drink4)
    assert_equal(90, @pub.check_customer_drunkennes(@customer1))
  end

  # test for selling food
  def test_sell_food
    @pub.sell_food(@customer1, @food1)
    assert_equal(9, @pub.food_stock(@food1))
    assert_equal(5, @pub.till)
    assert_equal(1, @customer1.food_counter)
    assert_equal(95, @customer1.wallet)
  end


end
