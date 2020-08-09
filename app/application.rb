class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end 
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      key_item = req.params["item"]
      resp.write handle_add(key_item)
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(key_item)
    if @@items.include?(key_item)
      @@cart << key_item
      return "added #{key_item}"
    else
      return "We don't have that item"
    end
  end

end

#Create a new route called /add that takes in a GET param with the key item. 
#This should check to see if that item is in @@items and then add it to the cart if it is. 
#Otherwise give an error