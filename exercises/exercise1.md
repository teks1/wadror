irb(main):010:0> Brewery.create(name:"BrewDog", year: 2007)
   (0.1ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", 2007], ["created_at", "2016-01-31 12:10:17.206922"], ["updated_at", "2016-01-31 12:10:17.206922"]]
   (3.5ms)  commit transaction
=> #<Brewery id: 8, name: "BrewDog", year: 2007, created_at: "2016-01-31 12:10:17", updated_at: "2016-01-31 12:10:17">
irb(main):011:0> b = Brewery.last
  Brewery Load (0.2ms)  SELECT  "breweries".* FROM "breweries"  ORDER BY "breweries"."id" DESC LIMIT 1
=> #<Brewery id: 8, name: "BrewDog", year: 2007, created_at: "2016-01-31 12:10:17", updated_at: "2016-01-31 12:10:17">
irb(main):012:0> b.name
=> "BrewDog"
irb(main):013:0> Beer
=> Beer(id: integer, name: string, style: string, brewery_id: integer, created_at: datetime, updated_at: datetime)
irb(main):014:0> b.id
=> 8
irb(main):015:0> Beer.create name:"Punk IPA", style: "IPA", brewery_id:b.id
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 8], ["created_at", "2016-01-31 12:12:47.984515"], ["updated_at", "2016-01-31 12:12:47.984515"]]
   (4.1ms)  commit transaction
=> #<Beer id: 22, name: "Punk IPA", style: "IPA", brewery_id: 8, created_at: "2016-01-31 12:12:47", updated_at: "2016-01-31 12:12:47">
irb(main):016:0> Beer.create name:"Nanny State", style: "lowalcohol", brewery_id:b.id
   (0.1ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "lowalcohol"], ["brewery_id", 8], ["created_at", "2016-01-31 12:13:57.660586"], ["updated_at", "2016-01-31 12:13:57.660586"]]
   (4.7ms)  commit transaction
=> #<Beer id: 23, name: "Nanny State", style: "lowalcohol", brewery_id: 8, created_at: "2016-01-31 12:13:57", updated_at: "2016-01-31 12:13:57">

irb(main):002:0> b = Beer.find_by(name:"Punk IPA")
  Beer Load (0.2ms)  SELECT  "beers".* FROM "beers" WHERE "beers"."name" = ? LIMIT 1  [["name", "Punk IPA"]]
=> #<Beer id: 8, name: "Punk IPA", style: "IPA", brewery_id: 4, created_at: "2016-01-31 12:32:11", updated_at: "2016-01-31 12:32:11">
irb(main):003:0> b.name
=> "Punk IPA"
irb(main):004:0> b.ratings.create score:11
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 11], ["beer_id", 8], ["created_at", "2016-01-31 12:33:52.968423"], ["updated_at", "2016-01-31 12:33:52.968423"]]
   (3.5ms)  commit transaction
=> #<Rating id: 1, score: 11, beer_id: 8, created_at: "2016-01-31 12:33:52", updated_at: "2016-01-31 12:33:52">
irb(main):005:0> b.ratings.create score:14
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 14], ["beer_id", 8], ["created_at", "2016-01-31 12:33:59.045126"], ["updated_at", "2016-01-31 12:33:59.045126"]]
   (2.7ms)  commit transaction
=> #<Rating id: 2, score: 14, beer_id: 8, created_at: "2016-01-31 12:33:59", updated_at: "2016-01-31 12:33:59">
irb(main):006:0> k = Beer.find_by(name:"Nanny State")
  Beer Load (0.2ms)  SELECT  "beers".* FROM "beers" WHERE "beers"."name" = ? LIMIT 1  [["name", "Nanny State"]]
=> #<Beer id: 9, name: "Nanny State", style: "Low alcohol", brewery_id: 4, created_at: "2016-01-31 12:32:11", updated_at: "2016-01-31 12:32:11">
irb(main):007:0> k.ratings.create score:8
   (0.1ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 8], ["beer_id", 9], ["created_at", "2016-01-31 12:34:33.811933"], ["updated_at", "2016-01-31 12:34:33.811933"]]
   (4.3ms)  commit transaction
=> #<Rating id: 3, score: 8, beer_id: 9, created_at: "2016-01-31 12:34:33", updated_at: "2016-01-31 12:34:33">
irb(main):008:0> k.ratings.create score:16
   (0.1ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 16], ["beer_id", 9], ["created_at", "2016-01-31 12:34:42.997792"], ["updated_at", "2016-01-31 12:34:42.997792"]]
   (3.4ms)  commit transaction
=> #<Rating id: 4, score: 16, beer_id: 9, created_at: "2016-01-31 12:34:42", updated_at: "2016-01-31 12:34:42">
