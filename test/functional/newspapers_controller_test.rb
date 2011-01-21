require 'test_helper'

class NewspapersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:newspapers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_newspaper
    assert_difference('Newspaper.count') do
      post :create, :newspaper => { }
    end

    assert_redirected_to newspaper_path(assigns(:newspaper))
  end

  def test_should_show_newspaper
    get :show, :id => newspapers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => newspapers(:one).id
    assert_response :success
  end

  def test_should_update_newspaper
    put :update, :id => newspapers(:one).id, :newspaper => { }
    assert_redirected_to newspaper_path(assigns(:newspaper))
  end

  def test_should_destroy_newspaper
    assert_difference('Newspaper.count', -1) do
      delete :destroy, :id => newspapers(:one).id
    end

    assert_redirected_to newspapers_path
  end
end
