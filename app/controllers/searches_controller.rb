class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = "BFRFFQTGVIOWDNVDQIZZ1JRTQ5W5ZP5LBFGMOWZ3TTORIPXI"
          req.params['client_secret'] = "5MOB5YFTIGOWMQHOK2HCVQTHLALYZH2MCIM1DN0YGXKLRM5B"
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          req.options.timeout = 1
        end
        body = JSON.parse(@resp.body)
        if @resp.success?
          @venues = body["response"]["venues"]
        else
          @error = body["meta"]["errorDetail"]
        end

      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
      end
      render 'search'
   end

end
