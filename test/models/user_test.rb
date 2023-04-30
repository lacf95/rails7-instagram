require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'present email' do
    user = User.new(name: 'Name')
    assert user.invalid?
  end

  test 'unique email' do
    User.create(email: 'name@mail.com', name: 'Name')
    user = User.new(email: 'name@mail.com', name: 'Name 2')
    assert user.invalid?
  end

  test 'valid email' do
    user = User.new(email: 'namemail.com', name: 'Name')
    assert user.invalid?
  end

  test 'present name' do
    user = User.new(email: 'name@mail.com')
    assert user.invalid?
  end
end
