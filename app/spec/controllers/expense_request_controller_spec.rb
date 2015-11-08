require 'rails_helper'

RSpec.describe ExpenseRequestsController, type: :request do

  before(:each) do
    User.delete_all
    @user_create = User.create({name: "James"})
    User.create({name: "Tom"})
    
    ExpenseRequest.delete_all
    @requestDate = Time.now
    @expenseRequest = ExpenseRequest.create(requestDate: @requestDate, requester: @user_create.id)
  end

  it "should find all request" do
    get "/users/#{@user_create.as_json["_id"]}/expense-requests"
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.size).to eq(1)
    puts "===="
    puts json[0]['requester']
    # expect(json[0]["requestDate"]).to eq(@requestDate)
    expect(json[0]['requester']['uri']).to eq("/users/#{@user_create.as_json["_id"]}")
    expect(json[0]['uri']).to eq("/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}")
  end
end
