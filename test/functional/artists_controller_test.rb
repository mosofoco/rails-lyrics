require File.dirname(__FILE__) + '/../test_helper'
require 'artists_controller'

# Re-raise errors caught by the controller.
class ArtistsController; def rescue_action(e) raise e end; end

class ArtistsControllerTest < Test::Unit::TestCase
  fixtures :artists

  def setup
    @controller = ArtistsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:artists)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_artist
    old_count = Artist.count
    post :create, :artist => { }
    assert_equal old_count + 1, Artist.count

    assert_redirected_to artist_path(assigns(:artist))
  end

  def test_should_show_artist
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_artist
    put :update, :id => 1, :artist => { }
    assert_redirected_to artist_path(assigns(:artist))
  end

  def test_should_destroy_artist
    old_count = Artist.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Artist.count

    assert_redirected_to artists_path
  end
end
