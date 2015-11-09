class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def parse_document_id(document)
    document.id.to_s
  end
  
  def parse_json_id(json)
    json["_id"].to_s
  end
  
  def parse_bason_id(bson)
    bson.to_s
  end
  
  def parse_next_leve(json, key, basePath)
    next_level_bson = json[key]
    json[key] = Hash.new
    json[key]['uri'] = "#{basePath}/#{next_level_bson.to_s}"
    json
  end
end
