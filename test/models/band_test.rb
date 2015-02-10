require 'test_helper'

class BandTest < ActiveSupport::TestCase

  def setup
    @user = users(:pete)
    @other_user = users(:archer)
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

  test "should tell if band is owned by a user or not" do
    assert @band.is_owned_by?(@user)
    assert_not @band.is_owned_by?(@other_user)
  end
end
