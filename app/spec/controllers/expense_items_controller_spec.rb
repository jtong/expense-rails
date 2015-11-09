require 'rails_helper'


RSpec.describe ExpenseItemsController, type: :request do

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
    Category.delete_all
    @category = Category.create( name: "normalCategory",
    )
    @newCategory = Category.create( name: "newCategory",
    )
    ExpenseItem.delete_all
    @expenseItem = ExpenseItem.create(expenseRequest: @expenseRequest,
        amount: 200.0,
        consumeDate: @requestDate,
        category: @category.id,
        comment: "didi"
    )
    
  end

  it "should get all expense items" do
    uri = "/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}"
    get "#{uri}/expense-items"
    json = JSON.parse(response.body)
    expect(json.size).to eq(1)
    # expect(json[0]["requestDate"]).to eq(@requestDate)
    expect(json[0]['category']['uri']).to eq("/expense-item-categories/#{@category.id}")
    expect(json[0]['uri']).to eq("#{uri}/expense-items/#{@expenseItem.id}")
    expect(json[0]['comment']).to eq("didi")
  end

 it "should create expense item" do
   uri = "/users/#{@user_create.as_json["_id"]}/expense-requests/#{@expenseRequest.as_json["_id"]}"
   post "#{uri}/expense-items", {
            amount: 201.0,
            categoryId: @newCategory.id,
            comment: "eat eat eat"
        }
   json = JSON.parse(response.body)
   # expect(json[0]["requestDate"]).to eq(@requestDate)
   expect(json['category']['uri']).to eq("/expense-item-categories/#{@newCategory.id}")
   expect(json['amount']).to eq(201.0)
   expect(json['comment']).to eq("eat eat eat")
 end
end


