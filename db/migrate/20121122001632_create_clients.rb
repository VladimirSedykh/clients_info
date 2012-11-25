class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :state
      t.string :activity
      t.string :description
      t.string :short_contacts
      t.string :role
      t.timestamps
    end
  end

  def down
    drop_table :clients
  end
end
