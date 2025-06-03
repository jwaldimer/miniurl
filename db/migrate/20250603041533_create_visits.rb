class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.references :mini_url, null: false, foreign_key: true
      t.inet :ip_address
      t.string :browser

      t.timestamps
    end
  end
end
