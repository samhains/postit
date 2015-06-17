class AddTimeStampsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :created_at, :timestamps
  end
end


