class CreateExternalUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :external_urls do |t|
      t.references :external_urls_request, null: false, foreign_key: true
      t.string :page_title, null: false
      t.string :url, null: false
    end

    add_index :external_urls, [:external_urls_request_id, :url], unique: true
  end
end
