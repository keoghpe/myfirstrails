require 'test_helper'

class BandsIndexTestTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:pete)
    @owner = users(:archer)
    @non_owner = users(:lana)
  end

  test "bands index" do
    log_in_as(@owner)
    get bands_path
    assert_template 'bands/index'
    assert_select 'div.pagination'
    first_page_of_bands = Band.paginate(page: 1)
    first_page_of_bands.each do |band|
      assert_select 'a[href=?]', band_path(band)
      assert_select 'h1', text: band.name
      # assert_select 'img[src=?]', the band image OR the default image
      if band.is_owned_by?(@owner)
        assert_select 'a[href=?]', band_path(band), text: 'delete', method: :delete
      end
    end
    # assert_difference 'User.count', -1 do
    #   delete user_path(@non_admin)
    # end
  end

  test "index as non user" do
    get bands_path
    assert_select 'a', text: 'delete', count: 0

    first_page_of_bands = Band.paginate(page: 1)
    first_page_of_bands.each do |band|
      assert_select 'a[href=?]', band_path(band)
      assert_select 'h1', text: band.name
      # assert_select 'img[src=?]', the band image OR the default image
    end
  end

  test "index as admin" do
    log_in_as(@admin)
    get bands_path
    assert_select 'a', text: 'delete', count: Band.per_page
  end
end
