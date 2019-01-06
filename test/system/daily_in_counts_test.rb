require "application_system_test_case"

class DailyInCountsTest < ApplicationSystemTestCase
  setup do
    @daily_in_count = daily_in_counts(:one)
  end

  test "visiting the index" do
    visit daily_in_counts_url
    assert_selector "h1", text: "Daily In Counts"
  end

  test "creating a Daily in count" do
    visit daily_in_counts_url
    click_on "New Daily In Count"

    fill_in "Count", with: @daily_in_count.count
    fill_in "Count date", with: @daily_in_count.count_date
    fill_in "Site", with: @daily_in_count.site_id
    click_on "Create Daily in count"

    assert_text "Daily in count was successfully created"
    click_on "Back"
  end

  test "updating a Daily in count" do
    visit daily_in_counts_url
    click_on "Edit", match: :first

    fill_in "Count", with: @daily_in_count.count
    fill_in "Count date", with: @daily_in_count.count_date
    fill_in "Site", with: @daily_in_count.site_id
    click_on "Update Daily in count"

    assert_text "Daily in count was successfully updated"
    click_on "Back"
  end

  test "destroying a Daily in count" do
    visit daily_in_counts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Daily in count was successfully destroyed"
  end
end
