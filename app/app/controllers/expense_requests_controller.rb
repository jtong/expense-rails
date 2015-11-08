class ExpenseRequestsController < ApplicationController
  def index
    @expenseRequests = ExpenseRequest.all #TODO: find by query in future
    result = @expenseRequests.as_json
    result.each do |request|
      jsonize(request, params)
      
    end

    render json: result, status: 200
  end
  
  def jsonize(item, params)
    item["uri"] = "/users/#{params[:userId]}/expense-requests/#{item["_id"]}"
    item[:id] = item["_id"].to_s
    if(item["requester"])
      item["requester"] = item["requester"].as_json
      item["requester"]['uri']= "/users/#{params[:userId]}"
    end
  end

end
