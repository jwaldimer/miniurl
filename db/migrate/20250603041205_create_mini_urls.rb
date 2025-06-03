class CreateMiniUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :mini_urls do |t|
      t.string :original_url
      t.string :alias
      t.string :creator_id
      t.text :description

      t.timestamps
    end
    add_index :mini_urls, :alias
  end
end
