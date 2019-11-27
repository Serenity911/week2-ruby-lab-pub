require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../food')

class TestFood < Minitest::Test

  def setup
    @food = Food.new("pizza", 5, 20)
  end

  def teat_food_has_name
    assert_equal("pizza", @food.name)
  end


end
