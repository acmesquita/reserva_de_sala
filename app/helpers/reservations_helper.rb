module ReservationsHelper

  def format_time(reserve)
    "#{l(reserve.date_start)} às #{reserve.date_start.strftime("%H:%M")} - #{reserve.date_end.strftime("%H:%M")}"
  end
end
