require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:archer)
    @band = bands(:ants)
    @differentband = bands(:neilyoung)
    @micropost = @user.microposts.new(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "band id should be valid" do
    #test a band
    @micropost = @user.microposts.new(content: "Lorem ipsum", band_id: @band.id)
    assert @micropost.valid?
    # test a non-existant band id
    @micropost = @user.microposts.new(content: "Ants lana!!", band_id: 1000)
    assert @micropost.valid?
    assert @micropost.band.nil?
    #test a different band
    @micropost = @user.microposts.new(content: "Lorem ipsum", band_id: @differentband.id)
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "     "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end
end
