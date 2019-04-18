require "application_system_test_case"

class DocumentosTest < ApplicationSystemTestCase
  setup do
    @documento = documentos(:one)
  end

  test "visiting the index" do
    visit documentos_url
    assert_selector "h1", text: "Documentos"
  end

  test "creating a Documento" do
    visit documentos_url
    click_on "New Documento"

    click_on "Create Documento"

    assert_text "Documento was successfully created"
    click_on "Back"
  end

  test "updating a Documento" do
    visit documentos_url
    click_on "Edit", match: :first

    click_on "Update Documento"

    assert_text "Documento was successfully updated"
    click_on "Back"
  end

  test "destroying a Documento" do
    visit documentos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Documento was successfully destroyed"
  end
end
