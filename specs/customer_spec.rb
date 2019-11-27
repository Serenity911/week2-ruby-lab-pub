require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer')

class TestCustomer < Minitest::Test

  def setup
    @customer = Customer.new("Lauren", 1000)
  end


  def test_get_customer_name
    assert_equal("Lauren", @customer.name)
  end

  def test_customer_wallet
    assert_equal(1000, @customer.wallet)
  end

end
