require 'open-uri'
require 'time'

module ButtCoins
  class Entry < Struct.new(:date, :price)
    include Comparable
    def <=> otr
      self.date <=> otr.date
    end

    def to_s
      return "#{self.date.httpdate}: #{self.price}"
    end
  end

  def self.mtgox_blocks
    url = "http://data.mtgox.com/api/1/BTCUSD/depth/fetch"
    data = JSON.parse(open(url).read)["return"]["asks"].map {|e| e["datetime"] = Time.at(e["stamp"].to_i/1000000); e }

    return data.map {|e| Entry.new(e["datetime"], e["price"]) }.sort
  end

  def self.mtgox_transactions
    # Last 2000 transactions on mtgox
    # http://bitcoincharts.com/about/markets-api/
    url = "http://api.bitcoincharts.com/v1/trades.csv?symbol=mtgoxUSD"
    data = CSV.new(open(url)).to_a.map do |date, amt, qty|
      Entry.new(Time.at(date.to_i), amt.to_f)
    end

    return data.sort
  end

  def self.thirty_day
    # Historical Data from BlockChain
    url = "http://blockchain.info/charts/market-price?showDataPoints=true&timespan=30days&show_header=true&daysAverageString=1&scale=0&format=csv"
    data = CSV.new(open(url)).to_a.map do |date, price|
      Entry.new(Time.at(date.to_i/1000), price.to_f)
    end

    return data.sort
  end
end
