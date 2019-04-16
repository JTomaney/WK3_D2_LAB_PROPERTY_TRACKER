require('pry-byebug')
require_relative('models/Property')

house0 = {'value' => '35_000', 'number_of_bedrooms' => '1', 'buy_let_status' => 'Sold', 'build' => 'Studio Flat'}
house1 = {'value' => '100_000', 'number_of_bedrooms' => '3', 'buy_let_status' => 'FOR SALE', 'build' => 'SEMI-DETACHED'}

property0 = Property.new(house0)
property1 = Property.new(house1)

property0.save()
property1.save()
property0.buy_let_status = 'FOR SALE'
property0.update()
# p property0

property1.delete()

Property.find(12)

p Property.find_by_status("FOR SALE")
