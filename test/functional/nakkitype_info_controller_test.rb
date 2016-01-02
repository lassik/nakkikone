require_relative '../minitest_helper'

describe NakkitypeInfosController do
  def json_response
    ActiveSupport::JSON.decode @response.body
  end

  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end

  before do
    FactoryGirl.create_list(:nakkitype_info, 2)
    test_user = FactoryGirl.create(:admin)
    login_as(test_user)

    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  it "index lists all infos" do
    get :index
    assert_response :success

    result_object = json_response

    assert_equal "1th title", result_object[0]["title"]
    assert_equal "2th title", result_object[1]["title"]

    assert_equal "1th description", result_object[0]["description"]
    assert_equal "2th description", result_object[1]["description"]
  end

  it "destroy deletes info" do
    remove_id = NakkitypeInfo.all.last[:id]

    delete :destroy, :id => remove_id, :format => :json
    assert_response :success

    NakkitypeInfo.count.must_equal 1
  end

  it "updates properly one info" do
    update_id = NakkitypeInfo.all.last[:id]

    put :update, :id => update_id, :title => "another title", :description => "another description", :format => :json
    assert_response :success

    assert_equal "another title", NakkitypeInfo.all.last[:title]
    assert_equal "another title", json_response["title"]
    assert_equal "another description", NakkitypeInfo.all.last[:description]
    assert_equal "another description", json_response["description"]
  end

  it "fails to update with invalid values" do
    update_id = NakkitypeInfo.all.last[:id]

    put :update, :id => update_id, :title => "1", :format => :json
    assert_response :bad_request

    json_response.keys.must_include "title"
  end

  it "creates properly one info" do
    post :create, :title => "new title", :description => "new description", :format => :json
    assert_response :success

    NakkitypeInfo.count.must_equal 3
    assert_equal "new title", NakkitypeInfo.all.last[:title]
    assert_equal "new title", json_response["title"]
    assert_equal "new description", NakkitypeInfo.all.last[:description]
    assert_equal "new description", json_response["description"]
  end

  it "fails to create with invalid values" do
    post :create, :title => "1", :format => :json
    assert_response :bad_request

    NakkitypeInfo.count.must_equal 2
    json_response.keys.must_include "title"
  end
end

