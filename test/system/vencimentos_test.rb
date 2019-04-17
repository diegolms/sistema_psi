require "application_system_test_case"

class VencimentosTest < ApplicationSystemTestCase
  setup do
    @vencimento = vencimentos(:one)
  end

  test "visiting the index" do
    visit vencimentos_url
    assert_selector "h1", text: "Vencimentos"
  end

  test "creating a Vencimento" do
    visit vencimentos_url
    click_on "New Vencimento"

    click_on "Create Vencimento"

    assert_text "Vencimento was successfully created"
    click_on "Back"
  end

  test "updating a Vencimento" do
    visit vencimentos_url
    click_on "Edit", match: :first

    click_on "Update Vencimento"

    assert_text "Vencimento was successfully updated"
    click_on "Back"
  end

  test "destroying a Vencimento" do
    visit vencimentos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vencimento was successfully destroyed"
  end
end
