class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.integer :user_id
      t.date :birthday
      t.string :image
      t.string :facebook_id
      t.string :facebook_link

      t.timestamps
    end
  end
end
