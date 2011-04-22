class User < ActiveRecord::Base
  
  has_many :posts, :dependent => :destroy
  
  before_create :set_as_admin_if_first_user
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
    end  
  end
  
  def set_as_admin_if_first_user
    self.is_admin = true if User.count == 0
  end
  
end
