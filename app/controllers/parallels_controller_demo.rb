class ParallelsController < ApplicationController
   skip_before_action :verify_authenticity_token
  def parallelrate
    require 'openssl'
    require 'open-uri'
    @items = []
    item = {}
    doc = Nokogiri::HTML(open('http://libgen.is/search.php?req=fg&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

    entries = doc.css('.lagos-market-rates-inner')
    rates = entries.css('table')[0].css('.table-line')
    @currencies = [:usd, :gbp, :eur]
    rates.each do |r|
      item = {}
      item[:date] = r.css('td')[0].text
      row = []
      r.css('td').each_with_index do |rc, i|
        next if i === 0
        buy, sell = rc.text.split('/')
        item[@currencies[i-1]] = {
          buy: buy.to_f,
          sell: sell.to_f
        }
      end

      @items << item      
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
    params.require(:rate).permit(
      :date, 
      :rates_usd, 
      :rates_eur, 
      :rates_gbp
    )
  end
end