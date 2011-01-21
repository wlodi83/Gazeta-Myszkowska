require 'test_helper'

class NespapersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:nespapers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_nespaper
    assert_difference('Nespaper.count') do
      post :create, :nespaper => { }
    end

    assert_redirected_to nespaper_path(assigns(:nespaper))
  end

  def test_should_show_nespaper
    get :show, :id => nespapers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => nespapers(:one).id
    assert_response :success
  end

  def test_should_update_nespaper
    put :update, :id => nespapers(:one).id, :nespaper => { }
    assert_redirected_to nespaper_path(assigns(:nespaper))
  end

  def test_should_destroy_nespaper
    assert_difference('Nespaper.count', -1) do
      delete :destroy, :id => nespapers(:one).id
    end

    assert_redirected_to nespapers_path
  end
end
