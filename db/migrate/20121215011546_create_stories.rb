class CreateStories < ActiveRecord::Migration
  def up
    create_table :stories do |t|
      t.string :name
      t.string :description
      t.integer :client_id
      t.timestamps
    end
  end

  def down
    drop_table :stories
  end
end
