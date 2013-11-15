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
end

desc "Get most recent entries in the block chain."
task :mtgox_blocks do
  url = "http://data.mtgox.com/api/1/BTCUSD/depth/fetch"
  data = JSON.parse(open(url).read)["return"]["asks"].map {|e| e["datetime"] = Time.at(e["stamp"].to_i/1000000); e }.sort do |a,b|
    a["datetime"] <=> b["datetime"]
  end

  data.each do |entry|
    puts "#{entry["datetime"].httpdate}: #{entry["price"]}"
  end
end

desc "Print last 2000 approved transactions on MtGox."
task :mtgox_trans do
  # Last 2000 transactions on mtgox
  # http://bitcoincharts.com/about/markets-api/
  url = "http://api.bitcoincharts.com/v1/trades.csv?symbol=mtgoxUSD"
  CSV.new(open(url)).each do |date, amt, qty|
    date = Time.at(date.to_i)
    puts "#{date.httpdate}: #{amt}"
  end
end

desc "Get last 30 day Average price."
task :thirty_day do
  # Historical Data from BlockChain
  url = "http://blockchain.info/charts/market-price?showDataPoints=true&timespan=30days&show_header=true&daysAverageString=1&scale=0&format=csv"
  CSV.new(open(url)).each do |date, price|
    date = Time.at(date.to_i/1000)
    price = price.to_f

    puts "#{date.httpdate}: #{price}"
  end
end
