class AddRemovedFields < ActiveRecord::Migration
  def up
    add_column :stories, :name, :string
  end

  def down
    remove_column :stories, :name
  end
end
