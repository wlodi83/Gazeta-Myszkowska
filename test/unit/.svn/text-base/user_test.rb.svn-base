require 'test/test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_create_valid_user
    user = User.new(:username => 'fred', :email => 'fred@example.com',
       :password => 'abc1234', :password_confirmation => 'abc1234',
       :profile => 'A regular gay')
     assert user.save
  end
  
  def test_invalid_duplicate_username
    user = User.new(:username => 'joe', :email => 'fred@example.com',
       :password => 'abc1234', :password_confirmation => 'abc1234',
       :profile => 'A regular gay')
    assert !user.save     
  end
  
end
