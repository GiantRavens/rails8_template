class Post < ApplicationRecord
  before_create :set_uuid
  
  private
  
  def set_uuid
    self.id = UUID7.generate if self.id.nil?
  end
end