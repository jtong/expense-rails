class ExpenseRequestsController < ApplicationController
  def index
    @expenseRequests = ExpenseRequest.all #TODO: find by query in future
    result = @expenseRequests.as_json
    result.each do |request|
      jsonize(request, params)
      
    end
    render json: result, status: 200
  end
  
  def create
    user = User.find(params[:userId])
    @expenseRequest = ExpenseRequest.create(requestDate: Time.now, requester: user.id, name: params[:name])
    render json: jsonize(@expenseRequest.as_json, params), status: 201
  end
  
  def get
    @expenseRequest = ExpenseRequest.find(params[:expenseRequestId])
    render json: jsonize(@expenseRequest.as_json, params), status: 200

  end
  
  def update
    @expenseRequest = ExpenseRequest.find(params[:expenseRequestId])
    updateAttributes = Hash.new
    updateAttributes[:approver] = User.find(params[:approverId]).id unless params[:approverId].nil?
    updateAttributes[:status] = params[:status] unless params[:status].nil? 
    @expenseRequest.update updateAttributes
    render json: jsonize(@expenseRequest.as_json, params), status: 200
  end
  
  def jsonize(item, params)
    item["uri"] = "/users/#{params[:userId]}/expense-requests/#{item["_id"]}"
    item[:id] = item["_id"].to_s
    # puts item
    if(item["requester"])
      parse_next_leve item, "requester", "/users"
      if(!item["approver"].nil?)
        parse_next_leve item, "approver", "/users"
      end
    end
    item
  end

  
end
