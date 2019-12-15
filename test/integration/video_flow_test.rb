require 'test_helper'

class VideoFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'can share a video' do
    sign_in users(:user001)
    get '/share'
    assert_response :success

    post '/videos',
         params: {
           video: { url: 'https://www.youtube.com/watch?v=zwuoTp3oLkA' }
         }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p', 'Video successfully shared.'
  end
end
