class ResponseController < ApplicationController

  def rate
    destination = Location.new( country: params[:destination][:country],
                                state: params[:destination][:state],
                                city: params[:destination][:city],
                                postal_code: params[:destination][:zip])

    package = Package.new(params[:package][:weight].to_i,
              [15, 15, 4.5],
              :units => :imperial )

    response = $fedex.find_rates($origin, destination, package)
    pretty_response = {}
    
    response.rates.each do |rate|
      pretty_response[rate.service_name] = {
        price: rate.price,
        delivery: rate.delivery_date ? rate.delivery_date.to_date : nil
        }
    end

    # sorted_response = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render json: pretty_response
  end
end
