require "application_system_test_case"

class CaixasTest < ApplicationSystemTestCase
  setup do
    @caixa = caixas(:one)
  end

  test "visiting the index" do
    visit caixas_url
    assert_selector "h1", text: "Caixas"
  end

  test "creating a Caixa" do
    visit caixas_url
    click_on "New Caixa"

    click_on "Create Caixa"

    assert_text "Caixa was successfully created"
    click_on "Back"
  end

  test "updating a Caixa" do
    visit caixas_url
    click_on "Edit", match: :first

    click_on "Update Caixa"

    assert_text "Caixa was successfully updated"
    click_on "Back"
  end

  test "destroying a Caixa" do
    visit caixas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Caixa was successfully destroyed"
  end
end
