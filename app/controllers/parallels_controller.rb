class ParallelsController < ApplicationController
   skip_before_action :verify_authenticity_token
  def parallelrate
    require 'openssl'
    require 'open-uri'
    @items = []
    item = {}
    theme = []
    doc = Nokogiri::HTML(open('https://www.abokifx.com/', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

    entries = doc.css('.lagos-market-rates-inner')
    rates = entries.css('table')[0].css('.table-line')
    rates.each do |r|
      r.css('td').each do |rc|
        theme.push rc.text
      end
      item[:value] = theme
      @items << item
      theme = []
    end      
    render template: 'parallels/home'
  end

  def create
    @s = Rate.new rate_params    
    if @s.save
      render json: @s, status: :ok
    else
      render json: {error: "Error"}, status: :error
    end 
  end

  private

  def rate_params
    params.require(:rate).permit(:date, :rates_usd, :rates_eur, :rates_gbp)
  end
end
