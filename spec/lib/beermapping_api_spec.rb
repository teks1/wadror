require 'rails_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("espoo")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Gallows Bird")
    expect(place.street).to eq("Merituulentie 30")
  end
  it "When HTTP GET returns empty entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*mikamikamaa/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("mikamikamaa")

    expect(places.size).to eq(0)
    place = places.first

    expect(place).to eq(nil)
  end
  it "When HTTP GET returns two or more entries, they are parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12410</id><name>Pikkulintu</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12410</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12410&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12410&amp;d=1&amp;type=norm</blogmap><street>Klaavuntie 11</street><city>Helsinki</city><state></state><zip>00910</zip><country>Finland</country><phone>+358 9 321 5040</phone><overall>91.6667</overall><imagecount>0</imagecount></location><location><id>18418</id><name>Bryggeri Helsinki</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18418</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18418&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18418&amp;d=1&amp;type=norm</blogmap><street>Sofiankatu 2</street><city>Helsinki</city><state></state><zip>FI-00170</zip><country>Finland</country><phone>010 235 2500</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*helsinki/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("helsinki")

    expect(places.size).to eq(2)
    
    place = places.second
    expect(place.name).to eq("Bryggeri Helsinki")
    expect(place.street).to eq("Sofiankatu 2")
  end

end