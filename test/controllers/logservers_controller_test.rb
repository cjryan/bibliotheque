require 'test_helper'

class LogserversControllerTest < ActionController::TestCase
  setup do
    @logserver = logservers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logservers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logserver" do
    assert_difference('Logserver.count') do
      post :create, logserver: { hostname: @logserver.hostname, ip: @logserver.ip }
    end

    assert_redirected_to logserver_path(assigns(:logserver))
  end

  test "should show logserver" do
    get :show, id: @logserver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logserver
    assert_response :success
  end

  test "should update logserver" do
    patch :update, id: @logserver, logserver: { hostname: @logserver.hostname, ip: @logserver.ip }
    assert_redirected_to logserver_path(assigns(:logserver))
  end

  test "should destroy logserver" do
    assert_difference('Logserver.count', -1) do
      delete :destroy, id: @logserver
    end

    assert_redirected_to logservers_path
  end
end
