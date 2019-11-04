module ReservationsHelper

  def format_time(reserve)
    "#{l(reserve.date_start)} às #{reserve.date_start.strftime("%H:%M")} - #{reserve.date_end.strftime("%H:%M")}"
  end

  def how_long(reserva)
    format_hours(reserva.date_start - Time.zone.now)
  end

  def hours_start
    (Array (9..18)).select{ |num| num > Time.zone.now.hour }.map {|num| "#{num}:00" }
  end

  def hours_end
    (Array (9..18)).select{ |num| num > Time.zone.now.hour + 1 }.map {|num| "#{num}:00" }
  end

  private

  def format_hours(time)
    str = "≃ "
    horas = time/3600
    minutos = (time%3600)/60
    if time < 0
      srt = "já aconteceu"
      return srt
    end
    if horas.to_i > 0
      str += "#{horas.to_i} horas "
    end
    if minutos.to_i > 0
      str += "#{minutos.to_i} minutos"
    end
    str
  end
end
