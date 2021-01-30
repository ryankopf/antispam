require "application_system_test_case"

module Antispam
  class ClearsTest < ApplicationSystemTestCase
    setup do
      @clear = antispam_clears(:one)
    end

    test "visiting the index" do
      visit clears_url
      assert_selector "h1", text: "Clears"
    end

    test "creating a Clear" do
      visit clears_url
      click_on "New Clear"

      fill_in "Answer", with: @clear.answer
      fill_in "Ip", with: @clear.ip
      fill_in "Result", with: @clear.result
      fill_in "Threat after", with: @clear.threat_after
      fill_in "Threat before", with: @clear.threat_before
      click_on "Create Clear"

      assert_text "Clear was successfully created"
      click_on "Back"
    end

    test "updating a Clear" do
      visit clears_url
      click_on "Edit", match: :first

      fill_in "Answer", with: @clear.answer
      fill_in "Ip", with: @clear.ip
      fill_in "Result", with: @clear.result
      fill_in "Threat after", with: @clear.threat_after
      fill_in "Threat before", with: @clear.threat_before
      click_on "Update Clear"

      assert_text "Clear was successfully updated"
      click_on "Back"
    end

    test "destroying a Clear" do
      visit clears_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Clear was successfully destroyed"
    end
  end
end
