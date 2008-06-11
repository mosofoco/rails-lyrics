require File.dirname(__FILE__) + '/../test_helper'
require 'lyrics_controller'

# Re-raise errors caught by the controller.
class LyricsController; def rescue_action(e) raise e end; end

class LyricsControllerTest < Test::Unit::TestCase
  fixtures :lyrics

  def setup
    @controller = LyricsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:lyrics)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_lyric
    old_count = Lyric.count
    post :create, :lyric => { }
    assert_equal old_count + 1, Lyric.count

    assert_redirected_to lyric_path(assigns(:lyric))
  end

  def test_should_show_lyric
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_lyric
    put :update, :id => 1, :lyric => { }
    assert_redirected_to lyric_path(assigns(:lyric))
  end

  def test_should_destroy_lyric
    old_count = Lyric.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Lyric.count

    assert_redirected_to lyrics_path
  end
end
