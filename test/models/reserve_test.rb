require 'test_helper'

class ReserveTest < ActiveSupport::TestCase
  test "validando reserva sem data inicio" do
    reserve = Reserve.new({date_end: DateTime.now, title: "Reunião teste", user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_start].first, "não pode ficar em branco"
  end

  test "validando reserva sem data fim" do
    reserve = Reserve.new({date_start: DateTime.now, title: "Reunião teste", user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_end].first, "não pode ficar em branco"
  end

  test "validando reserva sem data titulo" do
    reserve = Reserve.new({date_start: DateTime.now, date_end: DateTime.now, user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:title].first, "não pode ficar em branco"
  end
  
  test "validando reserva sem usuário" do
    reserve = Reserve.new({date_start: DateTime.now, date_end: DateTime.now, title: "Reunião teste"})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:user].first, "é obrigatório informar um usuário"
  end

  test "validando se data fim é maior que data inicio" do
    reserve = Reserve.new({date_start: DateTime.now, date_end: DateTime.now, title: "Reunião teste", user: users(:one)})
    assert reserve.save
  end

  test "validando se data inicio é maior que data fim" do
    reserve = Reserve.new({date_end: DateTime.now, date_start: DateTime.now, title: "Reunião teste", user: users(:one)})
    assert_not reserve.save
    assert_not_empty reserve.errors
    assert_equal reserve.errors[:date_end].first, "Data fim menor que a início."
  end

  test "validando reservas" do
    assert reservations(:one).valid?
    assert reservations(:two).valid?
  end
end
