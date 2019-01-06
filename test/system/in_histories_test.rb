require "application_system_test_case"

class InHistoriesTest < ApplicationSystemTestCase
  setup do
    @in_history = in_histories(:one)
  end

  test "visiting the index" do
    visit in_histories_url
    assert_selector "h1", text: "In Histories"
  end

  test "creating a In history" do
    visit in_histories_url
    click_on "New In History"

    fill_in "Chkd", with: @in_history.chkd
    fill_in "Ip", with: @in_history.ip
    fill_in "Rec time", with: @in_history.rec_time
    fill_in "Referer", with: @in_history.referer
    fill_in "Request line", with: @in_history.request_line
    fill_in "Site", with: @in_history.site_id
    click_on "Create In history"

    assert_text "In history was successfully created"
    click_on "Back"
  end

  test "updating a In history" do
    visit in_histories_url
    click_on "Edit", match: :first

    fill_in "Chkd", with: @in_history.chkd
    fill_in "Ip", with: @in_history.ip
    fill_in "Rec time", with: @in_history.rec_time
    fill_in "Referer", with: @in_history.referer
    fill_in "Request line", with: @in_history.request_line
    fill_in "Site", with: @in_history.site_id
    click_on "Update In history"

    assert_text "In history was successfully updated"
    click_on "Back"
  end

  test "destroying a In history" do
    visit in_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "In history was successfully destroyed"
  end
end
