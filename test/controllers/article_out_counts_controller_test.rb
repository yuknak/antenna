require 'test_helper'

class ArticleOutCountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_out_count = article_out_counts(:one)
  end

  test "should get index" do
    get article_out_counts_url
    assert_response :success
  end

  test "should get new" do
    get new_article_out_count_url
    assert_response :success
  end

  test "should create article_out_count" do
    assert_difference('ArticleOutCount.count') do
      post article_out_counts_url, params: { article_out_count: { article_id: @article_out_count.article_id, count: @article_out_count.count, last_time: @article_out_count.last_time } }
    end

    assert_redirected_to article_out_count_url(ArticleOutCount.last)
  end

  test "should show article_out_count" do
    get article_out_count_url(@article_out_count)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_out_count_url(@article_out_count)
    assert_response :success
  end

  test "should update article_out_count" do
    patch article_out_count_url(@article_out_count), params: { article_out_count: { article_id: @article_out_count.article_id, count: @article_out_count.count, last_time: @article_out_count.last_time } }
    assert_redirected_to article_out_count_url(@article_out_count)
  end

  test "should destroy article_out_count" do
    assert_difference('ArticleOutCount.count', -1) do
      delete article_out_count_url(@article_out_count)
    end

    assert_redirected_to article_out_counts_url
  end
end
