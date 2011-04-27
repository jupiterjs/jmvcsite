class Bucket
  
  def self.all
    [
      #{:name => 'Help', :tags => ['help', 'question'], :slug => 'help'},
      {:name => 'Apps', :tags => ['project', 'showcase', 'app', 'apps'], :slug => 'apps'},
      {:name => 'Examples', :tags => ['example', 'examples'], :slug => 'examples'},
      {:name => 'Plugins', :tags => ['plugin'], :slug => 'plugins'},
      {:name => 'Articles', :tags => ['article', 'articles'], :slug => 'articles'},
    ]
  end
  
  def self.find_by_slug(slug)
    self.all.select{|b| b[:slug] == slug}.first
  end
  
end