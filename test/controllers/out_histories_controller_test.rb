require 'test_helper'

class OutHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @out_history = out_histories(:one)
  end

  test "should get index" do
    get out_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_out_history_url
    assert_response :success
  end

  test "should create out_history" do
    assert_difference('OutHistory.count') do
      post out_histories_url, params: { out_history: { article_id: @out_history.article_id, chkd: @out_history.chkd, ip: @out_history.ip, rec_time: @out_history.rec_time, site_id: @out_history.site_id } }
    end

    assert_redirected_to out_history_url(OutHistory.last)
  end

  test "should show out_history" do
    get out_history_url(@out_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_out_history_url(@out_history)
    assert_response :success
  end

  test "should update out_history" do
    patch out_history_url(@out_history), params: { out_history: { article_id: @out_history.article_id, chkd: @out_history.chkd, ip: @out_history.ip, rec_time: @out_history.rec_time, site_id: @out_history.site_id } }
    assert_redirected_to out_history_url(@out_history)
  end

  test "should destroy out_history" do
    assert_difference('OutHistory.count', -1) do
      delete out_history_url(@out_history)
    end

    assert_redirected_to out_histories_url
  end
end
