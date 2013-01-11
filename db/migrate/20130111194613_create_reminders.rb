class CreateReminders < ActiveRecord::Migration
  def up
    create_table :reminders do |t|
      t.string :description
      t.integer :client_id
      t.timestamps
      t.datetime :scheduled_time
    end
  end

  def down
    drop_table :reminders
  end
end
