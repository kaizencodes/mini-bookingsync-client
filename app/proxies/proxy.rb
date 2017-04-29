require "yaml"
API = YAML.load_file('config/api.yml')[Rails.env]

class Proxy
  def initialize
    @conn = Faraday.new(url: API["url"])
    @token = API["token"]
  end

  def all
    response = @conn.get "/#{path}?token=#{@token}"
    JSON.parse(response.body)
  end

  def find(id)
    response = @conn.get "/#{path}/" + id.to_s + "/?token=#{@token}"
    JSON.parse(response.body)
  end

  def create(params)
    @conn.post do |req|
      req.url "/#{path}/"
      req.headers["Content-Type"] = "application/json"
      req.params = params.merge({token: @token})
    end
  end

  def update(id, params)
    @conn.put do |req|
      req.url "/#{path}/" + id.to_s
      req.headers["Content-Type"] = "application/json"
      req.params = params.merge({token: @token})
    end
  end

  def destroy(id)
    @conn.delete "/#{path}/" + id.to_s + "/?token=#{@token}"
  end

  def path
    raise 'Called abstract method: path'
  end
end
