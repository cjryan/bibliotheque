require 'test_helper'

class RundockerserversControllerTest < ActionController::TestCase
  setup do
    @rundockerserver = rundockerservers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rundockerservers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rundockerserver" do
    assert_difference('Rundockerserver.count') do
      post :create, rundockerserver: { dockerserver_id: @rundockerserver.dockerserver_id, image_id: @rundockerserver.image_id, jobcount: @rundockerserver.jobcount, run_id: @rundockerserver.run_id }
    end

    assert_redirected_to rundockerserver_path(assigns(:rundockerserver))
  end

  test "should show rundockerserver" do
    get :show, id: @rundockerserver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rundockerserver
    assert_response :success
  end

  test "should update rundockerserver" do
    patch :update, id: @rundockerserver, rundockerserver: { dockerserver_id: @rundockerserver.dockerserver_id, image_id: @rundockerserver.image_id, jobcount: @rundockerserver.jobcount, run_id: @rundockerserver.run_id }
    assert_redirected_to rundockerserver_path(assigns(:rundockerserver))
  end

  test "should destroy rundockerserver" do
    assert_difference('Rundockerserver.count', -1) do
      delete :destroy, id: @rundockerserver
    end

    assert_redirected_to rundockerservers_path
  end
end
