require 'test_helper'

class BandsIndexTestTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:pete)
    @owner = users(:archer)
    @non_owner = users(:lana)
  end
end
