class Reserve < ApplicationRecord
  belongs_to :user

  validates_presence_of :date_start, :date_end, :title
 
  validate :dates_is_possible?
  validate :dates_between_range?

  def dates_is_possible?
    return if [date_start.blank?, date_end.blank?].any?
    if date_end < date_start
      errors.add(:date_end, 'Data fim menor que a início.')
    end
  end

  def dates_between_range?
    return if [date_start.blank?, date_end.blank?].any?
    range = (Array (9..18)).map {|num| "#{num}:00" }
    if !range.include? date_end.strftime("%H:%M")
      errors.add(:date_end, 'Data fim fora do período.')
    end
    
    if !range.include? date_start.strftime("%H:%M")
      errors.add(:date_end, 'Data fim fora do período.')
    end
  end
 
end
