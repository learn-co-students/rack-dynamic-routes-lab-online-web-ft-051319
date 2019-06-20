class Application
  @@items = [Item.new("Mango", 0.99), Item.new("French Bread", 2.49)]
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    if req.path.match(/items/)
      item_name = req.path.split('/items/').last
      
      if @@items.find { |item| item.name == item_name }
        @@items.each { |item| resp.write "#{item.price}" if item.name == item_name }
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    
    resp.finish
  end
  
end