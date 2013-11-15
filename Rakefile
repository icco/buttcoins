require 'rubygems'
require 'bundler'
Bundler.require

require 'csv'
require 'open-uri'
require 'time'

require './lib/buttcoins'

desc "Do stuff!"
task :cron do
  raise NameError.new "COINBASE_API_KEY is unset." if not ENV['COINBASE_API_KEY']

  # Coin Base API load
  coinbase = Coinbase::Client.new(ENV['COINBASE_API_KEY'])
end

desc "Get most recent entries in the block chain."
task :mtgox_blocks do
  ButtCoins::mtgox_blocks.each do |entry|
    puts entry
  end
end

desc "Print last 2000 approved transactions on MtGox."
task :mtgox_trans do
  ButtCoins::mtgox_transactions.each do |entry|
    puts entry
  end
end

desc "Get last 30 day Average price."
task :thirty_day do
  ButtCoins::thirty_day.each do |entry|
    puts entry
  end
end
