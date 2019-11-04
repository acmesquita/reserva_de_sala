require 'test_helper'

class ReserveTest < ActiveSupport::TestCase
  test "validando reserva sem data inicio" do
    reserve = Reserve.new({date_end: Time.zone.parse('2019-10-20 09:00:00'), title: "Reunião teste", user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_start].first, "não pode ficar em branco"
  end

  test "validando reserva sem data fim" do
    reserve = Reserve.new({date_start: Time.zone.parse('2019-10-20 09:00:00'), title: "Reunião teste", user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_end].first, "não pode ficar em branco"
  end

  test "validando reserva sem data titulo" do
    reserve = Reserve.new({date_start: Time.zone.parse('2019-10-20 09:00:00'), date_end: Time.zone.parse('2019-10-20 10:00:00'), user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:title].first, "não pode ficar em branco"
  end
  
  test "validando reserva sem usuário" do
    reserve = Reserve.new({date_start: Time.zone.parse('2019-10-20 09:00:00'), date_end: Time.zone.parse('2019-10-20 10:00:00'), title: "Reunião teste"})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:user].first, "é obrigatório informar um usuário"
  end

  test "validando se data fim é maior que data inicio" do
    reserve = Reserve.new({date_start: Time.zone.parse('2019-10-20 10:00:00'), date_end: Time.zone.parse('2019-10-20 11:00:00'), title: "Reunião teste", user: users(:one)})
    assert reserve.save!
  end

  test "validando se data inicio é maior que data fim" do
    reserve = Reserve.new({date_end: Time.zone.parse('2019-10-20 09:00:00'), date_start: Time.zone.parse('2019-10-20 11:00:00'), title: "Reunião teste", user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_end].first, "Data fim menor que a início."
  end

  test "validando reservas fora do horário" do
    reserve = reservations(:one)
    assert_not reserve.valid?
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_end].first, "Data fim fora do período."
  end

  test "validando reserva" do
    assert reservations(:two).valid?
  end
end
