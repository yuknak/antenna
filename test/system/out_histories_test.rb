require "application_system_test_case"

class OutHistoriesTest < ApplicationSystemTestCase
  setup do
    @out_history = out_histories(:one)
  end

  test "visiting the index" do
    visit out_histories_url
    assert_selector "h1", text: "Out Histories"
  end

  test "creating a Out history" do
    visit out_histories_url
    click_on "New Out History"

    fill_in "Article", with: @out_history.article_id
    fill_in "Chkd", with: @out_history.chkd
    fill_in "Ip", with: @out_history.ip
    fill_in "Rec time", with: @out_history.rec_time
    fill_in "Site", with: @out_history.site_id
    click_on "Create Out history"

    assert_text "Out history was successfully created"
    click_on "Back"
  end

  test "updating a Out history" do
    visit out_histories_url
    click_on "Edit", match: :first

    fill_in "Article", with: @out_history.article_id
    fill_in "Chkd", with: @out_history.chkd
    fill_in "Ip", with: @out_history.ip
    fill_in "Rec time", with: @out_history.rec_time
    fill_in "Site", with: @out_history.site_id
    click_on "Update Out history"

    assert_text "Out history was successfully updated"
    click_on "Back"
  end

  test "destroying a Out history" do
    visit out_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Out history was successfully destroyed"
  end
end
