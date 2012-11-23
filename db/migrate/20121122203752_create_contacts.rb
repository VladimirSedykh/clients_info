class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :name
      t.string :cellphone
      t.string :phone
      t.string :email
      t.string :icq
      t.string :skype
      t.integer :client_id
      t.timestamps
    end
  end

  def down
    drop_table :clients
  end
end
