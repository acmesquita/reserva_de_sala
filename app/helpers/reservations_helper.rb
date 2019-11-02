module ReservationsHelper

  def format_time(reserve)
    "#{l(reserve.date_start)} às #{reserve.date_start.strftime("%H:%M")} - #{reserve.date_end.strftime("%H:%M")}"
  end

  def hours
    (Array (9..18)).map {|num| "#{num}:00" }
  end
end
