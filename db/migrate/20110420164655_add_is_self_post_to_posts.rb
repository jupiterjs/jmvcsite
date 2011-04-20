class AddIsSelfPostToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.boolean :is_self
    end
  end

  def self.down
  end
end
