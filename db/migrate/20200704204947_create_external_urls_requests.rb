class CreateExternalUrlsRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :external_urls_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.string :email, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end
  end
end
