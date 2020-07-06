class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :nickname, null: false
      t.string :email
      t.string :token, null: false
      t.string :secret, null: false

      t.timestamps
    end
    add_index :users, [:provider, :uid], unique: true
  end
end
