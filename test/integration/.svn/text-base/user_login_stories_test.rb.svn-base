require 'test/test_helper'

class LoginStoriesTest < ActionController::IntegrationTest
  fixtures :users, :pages
  
  def test_valid_admin_login
    go_to_login
    
    login :user => {:email => 'john@example.com', :password => '12345'}
    
    get users_url
    assert_response :redirect

  end
  
  private
  
  def go_to_login
    get 'account/login'
    assert_response :success
    assert_template 'account/login'
  end
  
  
  
  def login(options)
    post 'account/authenticate', options
    assert_response :redirect
  end
end