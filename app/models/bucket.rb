class Bucket
  
  def self.all
    [
      {:name => 'Help', :tags => ['help', 'question'], :slug => 'help'},
      {:name => 'Showcase', :tags => ['project', 'showcase'], :slug => 'showcase'},
      {:name => 'Plugins', :tags => ['plugin'], :slug => 'plugins'}
    ]
  end
  
  def self.find_by_slug(slug)
    self.all.select{|b| b[:slug] == slug}.first
  end
  
end