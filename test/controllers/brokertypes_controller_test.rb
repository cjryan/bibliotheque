require 'test_helper'

class BrokertypesControllerTest < ActionController::TestCase
  setup do
    @brokertype = brokertypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brokertypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brokertype" do
    assert_difference('Brokertype.count') do
      post :create, brokertype: { name: @brokertype.name }
    end

    assert_redirected_to brokertype_path(assigns(:brokertype))
  end

  test "should show brokertype" do
    get :show, id: @brokertype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brokertype
    assert_response :success
  end

  test "should update brokertype" do
    patch :update, id: @brokertype, brokertype: { name: @brokertype.name }
    assert_redirected_to brokertype_path(assigns(:brokertype))
  end

  test "should destroy brokertype" do
    assert_difference('Brokertype.count', -1) do
      delete :destroy, id: @brokertype
    end

    assert_redirected_to brokertypes_path
  end
end
