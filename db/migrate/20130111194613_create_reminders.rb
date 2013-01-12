class CreateReminders < ActiveRecord::Migration
  def up
    create_table :reminders do |t|
      t.string :description
      t.integer :client_id
      t.boolean :closed
      t.boolean :showed
      t.datetime :scheduled_time
      t.timestamps
    end
  end

  def down
    drop_table :reminders
  end
end
