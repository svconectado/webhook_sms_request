class Messages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :service, null: false
      t.string :payload, null: false
      t.string :response, null: true
      t.string :delivery, null: false
    end
  end
end
