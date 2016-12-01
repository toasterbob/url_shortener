class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.text :long_url, null: false
      t.text :short_url
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :shortened_urls, :short_url, unique: true
    add_index :shortened_urls, :user_id, unique: true
  end
end
