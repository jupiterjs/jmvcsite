class Post < ActiveRecord::Base
  
  belongs_to :user
  has_friendly_id :title, :use_slug => true
  acts_as_taggable
  
  validates_presence_of :title
  validate :presence_of_body_or_url
  
  before_save :process_body
  
  def presence_of_body_or_url
    errors.add_to_base('Please fill the body or the url') if body.blank? && url.blank?
  end
  
  def process_body
    b = self.body.gsub(/(\s+|\A)(https?:\/\/[\S]+)(\s+|\z)/, '<\2>')
    processed = Kramdown::Document.new(b).to_html
    doc = Nokogiri::HTML(processed)
    doc.css('a').each do |link|
      if link['href'].starts_with? 'https://gist.github' or link['href'].starts_with? 'http://gist.github'
        link.add_previous_sibling %Q(<div class="github-gist"><script src="#{link['href']}.js"></script></div>)
        link.remove
      end
    end
    processed = doc.css('body').inner_html
    self.processed_body = processed
  end
  
end


# == Schema Information
#
# Table name: posts
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  cached_slug :string(255)
#  url         :string(255)
#  post        :text
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  is_self     :boolean(1)
#

