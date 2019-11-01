require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "criando um usuário vazio e validando" do
    user = User.create({})
    assert_not user.valid?
  end

  test "criando um usuário somente com name" do
    user = User.create({name: "João Bobo"})
    assert_not user.valid?
  end

  test "criando um usuário valido" do
    user = User.create({name: "João Bobo", email: "joao@test.com", password: "12345678"})
    assert user.valid?
  end


  test "criando dois usuários iguais" do
    user1 = User.create({name: "João Bobo", email: "joao@test.com", password: "12345678"})
    user2 = User.create({name: "João Bobo", email: "joao@test.com", password: "12345678"})

    assert user1.valid?
    assert_not user2.valid?
    assert_not_empty user2.errors
    assert user2.errors[:email], "já está em uso"
  end
end
