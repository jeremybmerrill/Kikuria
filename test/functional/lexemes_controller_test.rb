require 'test_helper'

class LexemesControllerTest < ActionController::TestCase
  setup do
    @lexeme = lexemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lexemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lexeme" do
    assert_difference('Lexeme.count') do
      post :create, lexeme: @lexeme.attributes
    end

    assert_redirected_to lexeme_path(assigns(:lexeme))
  end

  test "should show lexeme" do
    get :show, id: @lexeme.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lexeme.to_param
    assert_response :success
  end

  test "should update lexeme" do
    put :update, id: @lexeme.to_param, lexeme: @lexeme.attributes
    assert_redirected_to lexeme_path(assigns(:lexeme))
  end

  test "should destroy lexeme" do
    assert_difference('Lexeme.count', -1) do
      delete :destroy, id: @lexeme.to_param
    end

    assert_redirected_to lexemes_path
  end
end
