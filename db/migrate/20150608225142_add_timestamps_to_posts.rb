class AddTimestampsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created_at, :timestamps
  end
end
