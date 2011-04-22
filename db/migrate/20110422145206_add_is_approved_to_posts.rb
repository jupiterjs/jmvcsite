class AddIsApprovedToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :is_approved, :boolean
  end

  def self.down
    remove_column :posts, :is_approved
  end
end
