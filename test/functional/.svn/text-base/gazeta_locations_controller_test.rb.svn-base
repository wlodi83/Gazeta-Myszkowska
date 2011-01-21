require 'test_helper'

class GazetaLocationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:gazeta_locations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_gazeta_location
    assert_difference('GazetaLocation.count') do
      post :create, :gazeta_location => { }
    end

    assert_redirected_to gazeta_location_path(assigns(:gazeta_location))
  end

  def test_should_show_gazeta_location
    get :show, :id => gazeta_locations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => gazeta_locations(:one).id
    assert_response :success
  end

  def test_should_update_gazeta_location
    put :update, :id => gazeta_locations(:one).id, :gazeta_location => { }
    assert_redirected_to gazeta_location_path(assigns(:gazeta_location))
  end

  def test_should_destroy_gazeta_location
    assert_difference('GazetaLocation.count', -1) do
      delete :destroy, :id => gazeta_locations(:one).id
    end

    assert_redirected_to gazeta_locations_path
  end
end
