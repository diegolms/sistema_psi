require 'test_helper'

class VencimentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vencimento = vencimentos(:one)
  end

  test "should get index" do
    get vencimentos_url
    assert_response :success
  end

  test "should get new" do
    get new_vencimento_url
    assert_response :success
  end

  test "should create vencimento" do
    assert_difference('Vencimento.count') do
      post vencimentos_url, params: { vencimento: {  } }
    end

    assert_redirected_to vencimento_url(Vencimento.last)
  end

  test "should show vencimento" do
    get vencimento_url(@vencimento)
    assert_response :success
  end

  test "should get edit" do
    get edit_vencimento_url(@vencimento)
    assert_response :success
  end

  test "should update vencimento" do
    patch vencimento_url(@vencimento), params: { vencimento: {  } }
    assert_redirected_to vencimento_url(@vencimento)
  end

  test "should destroy vencimento" do
    assert_difference('Vencimento.count', -1) do
      delete vencimento_url(@vencimento)
    end

    assert_redirected_to vencimentos_url
  end
end
