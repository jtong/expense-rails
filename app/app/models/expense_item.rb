class ExpenseItem
  include Mongoid::Document
  field :category, type: Category
  field :expenseRequest, type: ExpenseRequest
  field :amount, type:Float, default: 0.00
  field :consumeDate, type: Date
  field :comment, type: String
  belongs_to :expenseRequest, class_name: "ExpenseRequest"
  
end