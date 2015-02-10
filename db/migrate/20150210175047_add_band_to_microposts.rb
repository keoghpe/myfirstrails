class AddBandToMicroposts < ActiveRecord::Migration
  def change
    add_reference :microposts, :band, index: true
    add_foreign_key :microposts, :bands, default: nil
  end
end
