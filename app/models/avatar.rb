class Avatar < ActiveRecord::Base
  belongs_to :user

  def url(size)
    self.send("#{size}_url")
  end
end
