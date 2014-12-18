class ResponseController < ApplicationController

  def rate
    unless complete?
      render json: {error: "Please provide a complete query, with destination country, state, city and postal code set, as well as package weight."}, status: :bad_request
    else
      begin
        Timeout::timeout(25) {
          fedex_response = $fedex.find_rates($origin, destination, package)
          usps_response = $usps.find_rates($origin, destination, package)
          response_rates = fedex_response.rates + usps_response.rates
          pretty_response = {}

          response_rates.each do |rate|
            pretty_response[rate.service_name] = {
              price: rate.price,
              delivery: rate.delivery_date ? rate.delivery_date.to_date : nil
            }
          end
          render json: pretty_response
        }
      rescue Timeout::Error
        render json: {error: "Your request timed out."}, status: 408
      end

    end
  end

  def destination
    Location.new( country: params[:destination][:country],
    state: params[:destination][:state],
    city: params[:destination][:city],
    postal_code: params[:destination][:postal_code])
  end

  def complete?
    params[:destination][:country] && params[:destination][:state] && params[:destination][:city] && params[:destination][:postal_code] && params[:package][:weight]
  end

  def package
    Package.new(params[:package][:weight].to_i, [15, 15, 4.5], :units => :imperial )
  end

end
