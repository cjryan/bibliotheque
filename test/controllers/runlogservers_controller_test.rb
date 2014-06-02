require 'test_helper'

class RunlogserversControllerTest < ActionController::TestCase
  setup do
    @runlogserver = runlogservers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:runlogservers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create runlogserver" do
    assert_difference('Runlogserver.count') do
      post :create, runlogserver: { logserver_id: @runlogserver.logserver_id, run_id: @runlogserver.run_id }
    end

    assert_redirected_to runlogserver_path(assigns(:runlogserver))
  end

  test "should show runlogserver" do
    get :show, id: @runlogserver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @runlogserver
    assert_response :success
  end

  test "should update runlogserver" do
    patch :update, id: @runlogserver, runlogserver: { logserver_id: @runlogserver.logserver_id, run_id: @runlogserver.run_id }
    assert_redirected_to runlogserver_path(assigns(:runlogserver))
  end

  test "should destroy runlogserver" do
    assert_difference('Runlogserver.count', -1) do
      delete :destroy, id: @runlogserver
    end

    assert_redirected_to runlogservers_path
  end
end
