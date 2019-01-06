require 'test_helper'

class DailyOutCountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_out_count = daily_out_counts(:one)
  end

  test "should get index" do
    get daily_out_counts_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_out_count_url
    assert_response :success
  end

  test "should create daily_out_count" do
    assert_difference('DailyOutCount.count') do
      post daily_out_counts_url, params: { daily_out_count: { count: @daily_out_count.count, count_date: @daily_out_count.count_date, site_id: @daily_out_count.site_id } }
    end

    assert_redirected_to daily_out_count_url(DailyOutCount.last)
  end

  test "should show daily_out_count" do
    get daily_out_count_url(@daily_out_count)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_out_count_url(@daily_out_count)
    assert_response :success
  end

  test "should update daily_out_count" do
    patch daily_out_count_url(@daily_out_count), params: { daily_out_count: { count: @daily_out_count.count, count_date: @daily_out_count.count_date, site_id: @daily_out_count.site_id } }
    assert_redirected_to daily_out_count_url(@daily_out_count)
  end

  test "should destroy daily_out_count" do
    assert_difference('DailyOutCount.count', -1) do
      delete daily_out_count_url(@daily_out_count)
    end

    assert_redirected_to daily_out_counts_url
  end
end
