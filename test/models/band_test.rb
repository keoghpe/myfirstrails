require 'test_helper'

class BandTest < ActiveSupport::TestCase

  def setup
    @user = users(:pete)
    @band = @user.bands.new(name:"The dirt birds", bio: "Band from Dublin")
  end

  test "should be valid" do
    assert @band.valid?
  end

  test "user_id should be present" do
    @band.user_id = nil
    assert_not @band.valid?
  end

  test "band name should be present" do
    @band.name = "       "
    assert_not @band.valid?
  end

  test "band name should be no longer than 100 characters" do
    @band.name = "a" * 101
    assert_not @band.valid?
  end

  test "band bio should be no longer than 250 characters" do
    @band.name = "a" * 251
    assert_not @band.valid?
  end
end
