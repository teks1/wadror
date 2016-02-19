class BeermappingApi
 def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 20.minutes) { fetch_places_in(city) }
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.fetch_one_place(id)
    Rails.cache.fetch(id, expires_in: 20.minutes) { fetch_one_place_from_web(id) }
  end

  def self.fetch_one_place_from_web(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(id)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    Place.new(places)

  end

  def self.key
    "26e11884c78d5c5a38db57ba4162eb91"
  end
end