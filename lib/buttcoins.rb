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
end
