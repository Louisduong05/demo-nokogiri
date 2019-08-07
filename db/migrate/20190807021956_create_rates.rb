class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :id_lib
      t.date :date
      t.string :rates_usd
      t.string :rates_gbp
      t.string :rates_eur
      t.timestamps
    end
  end
end
