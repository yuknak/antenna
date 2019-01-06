require "application_system_test_case"

class DailyOutCountsTest < ApplicationSystemTestCase
  setup do
    @daily_out_count = daily_out_counts(:one)
  end

  test "visiting the index" do
    visit daily_out_counts_url
    assert_selector "h1", text: "Daily Out Counts"
  end

  test "creating a Daily out count" do
    visit daily_out_counts_url
    click_on "New Daily Out Count"

    fill_in "Count", with: @daily_out_count.count
    fill_in "Count date", with: @daily_out_count.count_date
    fill_in "Site", with: @daily_out_count.site_id
    click_on "Create Daily out count"

    assert_text "Daily out count was successfully created"
    click_on "Back"
  end

  test "updating a Daily out count" do
    visit daily_out_counts_url
    click_on "Edit", match: :first

    fill_in "Count", with: @daily_out_count.count
    fill_in "Count date", with: @daily_out_count.count_date
    fill_in "Site", with: @daily_out_count.site_id
    click_on "Update Daily out count"

    assert_text "Daily out count was successfully updated"
    click_on "Back"
  end

  test "destroying a Daily out count" do
    visit daily_out_counts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Daily out count was successfully destroyed"
  end
end
