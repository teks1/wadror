json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.beer do
  	json.size brewery.beers.size
  end
end
