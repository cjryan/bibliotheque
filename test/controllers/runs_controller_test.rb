require 'test_helper'

class RunsControllerTest < ActionController::TestCase
  setup do
    @run = runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create run" do
    assert_difference('Run.count') do
      post :create, run: { accounts: @run.accounts, accounts_per_job: @run.accounts_per_job, broker: @run.broker, brokertype_id: @run.brokertype_id, caseruns: @run.caseruns, maxgears: @run.maxgears, rhcbranch_id: @run.rhcbranch_id, tcms_password: @run.tcms_password, tcms_user: @run.tcms_user, testrun: @run.testrun }
    end

    assert_redirected_to run_path(assigns(:run))
  end

  test "should show run" do
    get :show, id: @run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @run
    assert_response :success
  end

  test "should update run" do
    patch :update, id: @run, run: { accounts: @run.accounts, accounts_per_job: @run.accounts_per_job, broker: @run.broker, brokertype_id: @run.brokertype_id, caseruns: @run.caseruns, maxgears: @run.maxgears, rhcbranch_id: @run.rhcbranch_id, tcms_password: @run.tcms_password, tcms_user: @run.tcms_user, testrun: @run.testrun }
    assert_redirected_to run_path(assigns(:run))
  end

  test "should destroy run" do
    assert_difference('Run.count', -1) do
      delete :destroy, id: @run
    end

    assert_redirected_to runs_path
  end
end
