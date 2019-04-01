require 'test_helper'

class RelatoriosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relatorios_index_url
    assert_response :success
  end

  test "should get show" do
    get relatorios_show_url
    assert_response :success
  end

end
