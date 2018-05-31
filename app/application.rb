require 'pry'

class Application

  @@items = ["Apples","Carrots","Pears","Figs"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.any?
        @@cart.each do |item|
          resp.write "#{item}\n"\
        end
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      search_term = req.params["q"]
      if @@items.include?(search_term)
        @@items << search_term
        resp.write "#{search_term} added"
      else
        resp.write "We don't have that item"
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "Added #{search_term}"
    else
      return "We don't have that item"
    end
  end
end
