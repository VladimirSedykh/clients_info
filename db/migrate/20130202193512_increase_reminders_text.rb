class IncreaseRemindersText < ActiveRecord::Migration
  def up
    change_column :reminders, :description, :text
  end

  def down
    change_column :reminders, :description, :string
  end
end
