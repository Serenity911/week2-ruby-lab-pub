require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../pub')
require_relative('../drink')
require_relative('../customer')

class TestPub < Minitest::Test

  def setup
    @drink1 = Drink.new("Cosmopolitan", 10)
    @drink2 = Drink.new("Tennants", 6)
    @pub = Pub.new("CodePub", 0, [@drink1, @drink2])
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

  def test_pub_drink_counter_starts_with_two_drinks
    assert_equal(2, @pub.drink_stock)
  end

  # def test_check_pub_has_drinks
  #   @pub.has_drinks
  #   assert_equal(true, true)
  # end

  def test_ask_customer_to_check_if_they_have_enough_money_for_a_drink
    assert_equal(true, @pub.ask_customer_to_check_money(@customer1, @drink1))
    assert_equal(false, @pub.ask_customer_to_check_money(@customer2, @drink1))
  end

  def test_drink_stock_reduces_by_one
    @pub.reduce_drink_stock(@drink1)
    assert_equal(1, @pub.drink_stock)
  end

  def test_drink_stock_do_not_reduce_if_drink_not_found
    @pub.reduce_drink_stock(@drink3)
    assert_equal(2, @pub.drink_stock)
  end

  def test_till_increases_by_price_of_drink
    @pub.increase_till_by_price_of_drink(@drink1)
    assert_equal(10, @pub.till)
  end

  def test_sell_a_drink
    @pub.sell_a_drink(@customer1, @drink1)
    assert_equal(1, @pub.drink_stock)
    assert_equal(10, @pub.till)
    assert_equal(1, @customer1.drink_counter)
    assert_equal(90, @customer1.wallet)
  end

  def test_do_not_sell_drink_if_not_in_stock
    @pub.sell_a_drink(@customer1, @drink3)
    assert_equal(2, @pub.drink_stock)
    assert_equal(0, @pub.till)
    assert_equal(0, @customer1.drink_counter)
    assert_equal(100, @customer1.wallet)
  end

  def test_do_not_sell_drink_if_customer_has_not_enough_money
    @pub.sell_a_drink(@customer2, @drink1)
    assert_equal(2, @pub.drink_stock)
    assert_equal(0, @pub.till)
    assert_equal(0, @customer2.drink_counter)
    assert_equal(1, @customer2.wallet)
  end

  def test_do_not_sell_drink_if_customer_is_not_old_enough
    @pub.sell_a_drink(@customer3, @drink1)
    assert_equal(2, @pub.drink_stock)
    assert_equal(0, @pub.till)
    assert_equal(0, @customer3.drink_counter)
    assert_equal(50, @customer3.wallet)
  end

  def test_sell_drink_if_customer_is_old_enough
    @pub.sell_a_drink(@customer1, @drink1)
    assert_equal(1, @pub.drink_stock)
    assert_equal(10, @pub.till)
    assert_equal(1, @customer1.drink_counter)
    assert_equal(90, @customer1.wallet)
  end

  def test_customer_is_old_enough_to_drink
    customer_old_enough = @pub.check_minimum_age(@customer1)
    assert_equal(true, customer_old_enough)
  end

  def test_customer_is_old_enough_to_drink
    customer_not_old_enough = @pub.check_minimum_age(@customer3)
    assert_equal(false, customer_not_old_enough)
  end

end
