
class Application

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #the path in question should look something like this "localhost9292:items/apples"
      item_name =  req.path.split("/items/").last #getting the item name from the url path

      if Item.all.map{|item| item.name}.include?(item_name) #checking if the list of all items contains the item being searched for
        item = Item.all.find{|item| item.name == item_name} #getting the instance of the item that is being searched
        resp.write item.price #printing out the price, which is the additional detail for the item 
      else
        resp.write "Item not found" #prints this if the item isnt within the Item class list
        resp.status = 400
      end

    else
      resp.write "Route not found"
      resp.status = 404

    end

    resp.finish

  end

end
