require "application_system_test_case"

class ArticleOutCountsTest < ApplicationSystemTestCase
  setup do
    @article_out_count = article_out_counts(:one)
  end

  test "visiting the index" do
    visit article_out_counts_url
    assert_selector "h1", text: "Article Out Counts"
  end

  test "creating a Article out count" do
    visit article_out_counts_url
    click_on "New Article Out Count"

    fill_in "Article", with: @article_out_count.article_id
    fill_in "Count", with: @article_out_count.count
    fill_in "Last time", with: @article_out_count.last_time
    click_on "Create Article out count"

    assert_text "Article out count was successfully created"
    click_on "Back"
  end

  test "updating a Article out count" do
    visit article_out_counts_url
    click_on "Edit", match: :first

    fill_in "Article", with: @article_out_count.article_id
    fill_in "Count", with: @article_out_count.count
    fill_in "Last time", with: @article_out_count.last_time
    click_on "Update Article out count"

    assert_text "Article out count was successfully updated"
    click_on "Back"
  end

  test "destroying a Article out count" do
    visit article_out_counts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Article out count was successfully destroyed"
  end
end
