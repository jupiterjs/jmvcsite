class RenamePostToBodyInPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.rename :post, :body
    end
  end

  def self.down
  end
end
