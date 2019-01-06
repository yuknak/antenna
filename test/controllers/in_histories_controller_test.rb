require 'test_helper'

class InHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @in_history = in_histories(:one)
  end

  test "should get index" do
    get in_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_in_history_url
    assert_response :success
  end

  test "should create in_history" do
    assert_difference('InHistory.count') do
      post in_histories_url, params: { in_history: { chkd: @in_history.chkd, ip: @in_history.ip, rec_time: @in_history.rec_time, referer: @in_history.referer, request_line: @in_history.request_line, site_id: @in_history.site_id } }
    end

    assert_redirected_to in_history_url(InHistory.last)
  end

  test "should show in_history" do
    get in_history_url(@in_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_in_history_url(@in_history)
    assert_response :success
  end

  test "should update in_history" do
    patch in_history_url(@in_history), params: { in_history: { chkd: @in_history.chkd, ip: @in_history.ip, rec_time: @in_history.rec_time, referer: @in_history.referer, request_line: @in_history.request_line, site_id: @in_history.site_id } }
    assert_redirected_to in_history_url(@in_history)
  end

  test "should destroy in_history" do
    assert_difference('InHistory.count', -1) do
      delete in_history_url(@in_history)
    end

    assert_redirected_to in_histories_url
  end
end
