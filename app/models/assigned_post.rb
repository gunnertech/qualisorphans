class AssignedPost < ActiveRecord::Base
  belongs_to :orphan
  belongs_to :post
end
