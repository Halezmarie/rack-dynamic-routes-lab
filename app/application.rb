class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        
        if req.path.match(/items/)
            item_from_path = req.path.split("/items/").last
            #splitting the last so we can detect 
            item = @@items.detect{|item| item.name == item_from_path}
            if item
                item_price = item.price
                resp.write item_price
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