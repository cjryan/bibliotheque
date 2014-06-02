require 'test_helper'

class RhcbranchesControllerTest < ActionController::TestCase
  setup do
    @rhcbranch = rhcbranches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rhcbranches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rhcbranch" do
    assert_difference('Rhcbranch.count') do
      post :create, rhcbranch: { name: @rhcbranch.name }
    end

    assert_redirected_to rhcbranch_path(assigns(:rhcbranch))
  end

  test "should show rhcbranch" do
    get :show, id: @rhcbranch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rhcbranch
    assert_response :success
  end

  test "should update rhcbranch" do
    patch :update, id: @rhcbranch, rhcbranch: { name: @rhcbranch.name }
    assert_redirected_to rhcbranch_path(assigns(:rhcbranch))
  end

  test "should destroy rhcbranch" do
    assert_difference('Rhcbranch.count', -1) do
      delete :destroy, id: @rhcbranch
    end

    assert_redirected_to rhcbranches_path
  end
end
