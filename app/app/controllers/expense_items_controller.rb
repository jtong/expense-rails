class ExpenseItemsController < ApplicationController
  
  def index
    @expenseItems = ExpenseItem.all #TODO: find by query in future
    result = @expenseItems.as_json
    result.each do |request|
      puts "=== #{request}"

      jsonize(request, params)

    end
    render json: result, status: 200
  end

  def jsonize(item, params)
    item[:id] = item["_id"].to_s
    item["uri"] = "/users/#{params[:userId]}/expense-requests/#{item["expenseRequest"]["_id"]}/expense-items/#{item[:id]}"
    parse_next_leve item, "category", "/expense-item-categories"
    item
  end

end
