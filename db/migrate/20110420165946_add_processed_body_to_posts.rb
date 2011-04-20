class AddProcessedBodyToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.text :processed_body
    end
  end

  def self.down
  end
end
