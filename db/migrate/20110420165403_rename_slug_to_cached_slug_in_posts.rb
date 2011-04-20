class RenameSlugToCachedSlugInPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.rename :slug, :cached_slug
    end
  end

  def self.down
  end
end
