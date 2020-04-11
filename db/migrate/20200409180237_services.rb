class Services < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :service, null: false
      t.string :description, null: true
      t.string :endpoint, null: false
    end
    add_index :services, :service, unique: true
  end
end
