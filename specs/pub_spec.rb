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
    @customer1 = Customer.new("SiggyDaMan", 100)
    @customer2 = Customer.new("Silvia", 1)
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


end
