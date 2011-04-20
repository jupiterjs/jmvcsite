require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

