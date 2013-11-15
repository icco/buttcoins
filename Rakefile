require 'rubygems'
require 'bundler'
Bundler.require

require 'csv'
require 'open-uri'
require 'time'

desc "Do stuff!"
task :cron do
  raise NameError.new "COINBASE_API_KEY is unset." if not ENV['COINBASE_API_KEY']

  # Coin Base API load
  coinbase = Coinbase::Client.new(ENV['COINBASE_API_KEY'])

  # Last 2000 transactions on mtgox
  # http://bitcoincharts.com/about/markets-api/
  url = "http://api.bitcoincharts.com/v1/trades.csv?symbol=mtgoxUSD"
  CSV.new(open(url)).each do |date, amt, qty|
    date = Time.at(date.to_i)
    total = (qty.to_f) * (amt.to_f)

    #puts "#{date.httpdate}: #{amt}"
  end


  # Historical Data from BlockChain
  url = "http://blockchain.info/charts/market-price?showDataPoints=true&timespan=30days&show_header=true&daysAverageString=1&scale=0&format=csv"
  CSV.new(open(url)).each do |date, price|
    date = Time.at(date.to_i/1000)
    price = price.to_f

    puts "#{date.httpdate}: #{price}"
  end
end
