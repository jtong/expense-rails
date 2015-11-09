require 'rails_helper'

RSpec.describe ExpenseRequestsController, type: :request do

  before(:each) do
    User.delete_all
    @user_create = User.create({name: "James"})
    @approver = User.create({name: "Tom"})
    
    ExpenseRequest.delete_all
    @requestDate = Time.now
    @expenseRequest = ExpenseRequest.create(requestDate: @requestDate, 
        requester: @user_create.id, name: "test",
        approver: @approver.id,
        status: "APPROVED")
    
    
  end

  it "should find all request" do
    get "/users/#{@user_create.as_json["_id"]}/expense-requests"
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.size).to eq(1)
    # expect(json[0]["requestDate"]).to eq(@requestDate)
    expect(json[0]['requester']['uri']).to eq("/users/#{@user_create.as_json["_id"]}")
    expect(json[0]['uri']).to eq("/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}")
  end

  it "should create a new request" do # TODO: 时间没有测
    post "/users/#{@user_create.as_json["_id"]}/expense-requests", {
          name: "expense 1"
                                                                     
         }
    expect(response).to have_http_status(201)

    json = JSON.parse(response.body)
    expect(json['requester']['uri']).to eq("/users/#{@user_create.as_json["_id"]}")
    expect(json['name']).to eq("expense 1")
    expect(json['approver']).to eq(nil)
  end

  it "should get request by id" do
    uri = "/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}"
    get uri
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json["requestDate"]).to eq(@requestDate.strftime("%Y-%m-%d"))
    expect(json["amount"]).to eq(0.0)
    expect(json["status"]).to eq("APPROVED")
    expect(json["approver"]["uri"]).to eq("/users/#{@approver.as_json["_id"]}")
    expect(json['requester']['uri']).to eq("/users/#{@user_create.as_json["_id"]}")
    expect(json['uri']).to eq("/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}")
  end

  
  it "should update request by id" do
    uri = "/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}"
    put uri, {
               name: "UPDATED",
               approverId: @user_create._id.to_s,
               status: "REJECT"
           }
    expect(response).to have_http_status(200)

    puts response.body
    json = JSON.parse(response.body)
    expect(json["requestDate"]).to eq(@requestDate.strftime("%Y-%m-%d"))
    expect(json["amount"]).to eq(0.0)
    expect(json["approver"]["uri"]).to eq("/users/#{@user_create.as_json["_id"]}")
    expect(json['requester']['uri']).to eq("/users/#{@user_create.as_json["_id"]}")

  end


end
