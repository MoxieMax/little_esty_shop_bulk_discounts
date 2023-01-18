class ApiService
  # def get_url(url)
  #   Faraday.get(url)
  #   # response.body
  #   # binding.pry
  # end
  # 
  # def data
  #   get_url(url).body
  # end
  
  def get_url(url)
    response = Faraday.get(url)
    data = response.body
    JSON.parse(data, symbolize_names:  true)
  end
end