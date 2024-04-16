class Api::FindZipCodeServices
  def self.find(zip_code)
    url = "http://viacep.com.br/ws/#{zip_code}/json/"

    response = HTTParty.get(url)
    return nil if response.code != 200

    response.symbolize_keys
  end
end
