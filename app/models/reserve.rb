class Reserve < ApplicationRecord
  belongs_to :user

  validates_presence_of :date_start, :date_end, :title
 
  validate :dates_is_possible?

  def dates_is_possible?
    return if [date_start.blank?, date_end.blank?].any?
    if date_end < date_start
      errors.add(:date_end, 'Data fim menor que a início.')
    end
  end
 
  # validates :date_ok?

  # def date_ok?
  #   puts 'entrou aqui'
  #   if( date_start < date_end )
  #     errors.add(:date_end, 'Data início maior que data fim')
  #   end
  # end
end
