require 'test_helper'

class NewslettersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:newsletters)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_newsletter
    assert_difference('Newsletter.count') do
      post :create, :newsletter => { }
    end

    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  def test_should_show_newsletter
    get :show, :id => newsletters(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => newsletters(:one).id
    assert_response :success
  end

  def test_should_update_newsletter
    put :update, :id => newsletters(:one).id, :newsletter => { }
    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  def test_should_destroy_newsletter
    assert_difference('Newsletter.count', -1) do
      delete :destroy, :id => newsletters(:one).id
    end

    assert_redirected_to newsletters_path
  end
end
