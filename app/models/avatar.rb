class Avatar < ActiveRecord::Base
  belongs_to :user

  def path(size)
    self.send("#{size}_path")
  end
end
