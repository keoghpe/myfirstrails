class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.text :bio
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
