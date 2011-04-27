class Post < ActiveRecord::Base
  
  attr_protected :is_approved
  
  belongs_to :user
  
  has_friendly_id :title, :use_slug => true
  acts_as_taggable
  
  validates_presence_of :title
  validate :presence_of_body_or_url
  validates_presence_of :user
  validates_presence_of :tag_list
  
  before_save :process_body
  before_save :set_is_approved
  
  scope :approved, where(:is_approved => true) 
  
  def title=(html)
    write_attribute(:title, Sanitize.clean(html))
  end
  
  def url=(html)
    write_attribute(:url, Sanitize.clean(html))
  end
  
  def tag_list_with_sanitize=(raw_tags)
    clean_tags = Sanitize.clean(raw_tags)
    self.tag_list_without_sanitize = clean_tags
  end
  
  alias_method_chain :tag_list=, :sanitize
  
  def set_is_approved
    if self.user.is_admin?
      self.is_approved = true
    end
  end
  
  def presence_of_body_or_url
    errors.add_to_base('Please fill the body or the url') if body.blank? && url.blank?
  end
  
  def process_body
    #b = self.body.gsub(/(\s+|\A)(https?:\/\/[\S]+)(\s+|\z)/, ' <\2> ')
    self.processed_body = Sanitize.clean(
                            RDiscount.new(self.body.strip).to_html, 
                            :elements => ['a', 'span', 'img', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'pre', 'code', 'b', 'i', 'strong', 'em', 'ul', 'li', 'ol', 'hr', 'br'],
                            :attributes => {'a' => ['href', 'title'], 'img' => ['src', 'title']},
                            :protocols => {'a' => {'href' => ['http', 'https', 'mailto']}})
  end
  
  def is_editable?
    10.minutes.ago.to_i - self.created_at.to_i < 0
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

