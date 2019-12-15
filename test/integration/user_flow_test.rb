require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  test 'can see the welcome page' do
    get '/'
    assert_select 'h1', 'Funny Movies'
  end

  test 'can signup' do
    post '/users',
         params: {
           user: { username: 'test', password: 'test1234' }
         }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p', 'Welcome! You have signed up successfully.'
  end

  test 'can logout' do
    delete '/users/sign_out'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p', 'Signed out successfully.'
  end

  test 'can login' do
    post '/users',
         params: {
           user: { username: 'test', password: 'test1234' }
         }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p .button', 'Share a movie'
  end
end
