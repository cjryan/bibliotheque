require 'test_helper'

class DockerInfoControllerTest < ActionController::TestCase
  test "should get get_docker_images" do
    get :get_docker_images
    assert_response :success
  end

end
