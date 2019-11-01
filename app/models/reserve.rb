class Reserve < ApplicationRecord
  belongs_to :user

  validates :date_start, :date_end, :title, presence: true
end
