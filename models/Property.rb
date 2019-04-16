require('pg')
require('pry-byebug')

class Property

  attr_reader :id, :number_of_bedrooms, :build
  attr_accessor :value, :buy_let_status

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @value = details['value'].to_i
    @number_of_bedrooms = details['number_of_bedrooms'].to_i
    @buy_let_status = details['buy_let_status']
    @build = details['build']
  end

  def save
    db = PG.connect({dbname: 'real_estate_properties', host: 'localhost'})
    sql = 'INSERT INTO real_estate_properties(value, number_of_bedrooms, buy_let_status, build) VALUES ($1, $2, $3, $4) RETURNING id;'
    values = [@value, @number_of_bedrooms, @buy_let_status, @build]
    db.prepare("save", sql)
    property_hashes = db.exec_prepared("save", values)
    @id = property_hashes[0]['id']
    db.close()
  end

  def update
    db = PG.connect({dbname: 'real_estate_properties', host: 'localhost'})
    sql = 'UPDATE real_estate_properties SET (value, number_of_bedrooms, buy_let_status, build) = ($1, $2, $3, $4) WHERE id = $5;'
    values = [@value, @number_of_bedrooms, @buy_let_status, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete
    db = PG.connect({dbname: 'real_estate_properties', host: 'localhost'})
    sql = 'DELETE FROM real_estate_properties WHERE id = $1;'
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Property.find(id)
    db = PG.connect({dbname: 'real_estate_properties', host: 'localhost'})
    sql = 'SELECT * FROM real_estate_properties WHERE id = $1;'
    values = [id]
    db.prepare("find", sql)
    result_hashes = db.exec_prepared("find", values)
    result = result_hashes.map { |result_hash| Property.new(result_hash)}
    db.close()
    return result
  end

  def Property.find_by_status(status)
    db = PG.connect({dbname: 'real_estate_properties', host: 'localhost'})
    sql = 'SELECT * FROM real_estate_properties WHERE buy_let_status = $1;'
    values = [status]
    db.prepare("find_by_status", sql)
    result_hashes = db.exec_prepared("find_by_status", values)
    result = result_hashes.map { |result_hash| Property.new(result_hash)}
    db.close()
    return result
  end

end
