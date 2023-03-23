require "test_helper"

class MedicalHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get medical_histories_show_url
    assert_response :success
  end
end
