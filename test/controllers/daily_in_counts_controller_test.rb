require 'test_helper'

class DailyInCountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_in_count = daily_in_counts(:one)
  end

  test "should get index" do
    get daily_in_counts_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_in_count_url
    assert_response :success
  end

  test "should create daily_in_count" do
    assert_difference('DailyInCount.count') do
      post daily_in_counts_url, params: { daily_in_count: { count: @daily_in_count.count, count_date: @daily_in_count.count_date, site_id: @daily_in_count.site_id } }
    end

    assert_redirected_to daily_in_count_url(DailyInCount.last)
  end

  test "should show daily_in_count" do
    get daily_in_count_url(@daily_in_count)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_in_count_url(@daily_in_count)
    assert_response :success
  end

  test "should update daily_in_count" do
    patch daily_in_count_url(@daily_in_count), params: { daily_in_count: { count: @daily_in_count.count, count_date: @daily_in_count.count_date, site_id: @daily_in_count.site_id } }
    assert_redirected_to daily_in_count_url(@daily_in_count)
  end

  test "should destroy daily_in_count" do
    assert_difference('DailyInCount.count', -1) do
      delete daily_in_count_url(@daily_in_count)
    end

    assert_redirected_to daily_in_counts_url
  end
end
