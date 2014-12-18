$fedex = Fedex::Shipment.new(:key => ENV[FEDEX_KEY],
                            :password => ENV[FEDEX_PASSWORD],
                            :account_number => ENV[FEDEX_ACCOUNT],
                            :meter => ENV[FEDEX_METER],
                            :mode => 'test')
