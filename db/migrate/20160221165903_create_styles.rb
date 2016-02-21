class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    styles_from_beers = Beer.all.map {|b| b.style}.uniq
   
    styles_from_beers.each do |s|
        Style.create(name: s.to_s, description: "Kuvaus")
    end
    
  end
end
