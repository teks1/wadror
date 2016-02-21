class RenameStyleFromBeers < ActiveRecord::Migration
  def change
    change_table :beers do |t|
        t.rename :style, :old_style
        t.integer :style_id
    end
 
    Beer.all.each do |b|
        b.style = Style.find_by(name: b.old_style)
        b.save
    end
 
  end
end
