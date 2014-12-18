# $fedex = Fedex::Shipment.new(:key => ENV["FEDEX_KEY"],
#                             :password => ENV["FEDEX_PASSWORD"],
#                             :account_number => ENV["FEDEX_ACCOUNT"],
#                             :meter => ENV["FEDEX_METER"],
#                             :mode => 'test')

require 'active_shipping'
include ActiveMerchant::Shipping

$fedex = FedEx.new(login: ENV["FEDEX_METER"],
                   password: ENV["FEDEX_PASSWORD"],
                   key: ENV["FEDEX_KEY"],
                   account: ENV["FEDEX_ACCOUNT"],
                   test: true)

$usps = USPS.new(login: ENV["USPS_LOGIN"])

# $ups = UPS.new(login: 'auntjudy',
#               password: 'secret',
#               key: 'xml-access-key')

$origin = Location.new(:country => 'US',
                       :state => 'CA',
                       :city => 'Beverly Hills',
                       :zip => '90210')
