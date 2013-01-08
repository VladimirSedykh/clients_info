#!/bin/env ruby
# encoding: utf-8
class CreateSatates < ActiveRecord::Migration
  def up
    create_table :states do |t|
      t.string :name
    end

    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO states (name)
      VALUES ( 'Винницкая'), ('Волынская'), ('Днепропетровская'), ('Донецкая'), ('Житомирская'), ('Закарпатская'),
              ('Запорожская'), ('Ивано-Франковская'), ('Киевская'), ('Кировоградская'), ('Крым'), ('Луганская'),
              ('Львовская'), ('Николаевская'), ('Одесская'), ('Полтавская'), ('Ровенская'), ('Сумская'), ('Тернопольская'),
              ('Харьковская'), ('Херсонская'), ('Хмельницкая'), ('Черкасская'), ('Черниговская'), ('Черновицкая')
      SQL
  end

  def down
    drop_table :states
  end
end
