class Reserve < ApplicationRecord
  belongs_to :user

  validates_presence_of :date_start, :date_end, :title
  
end
