require 'nokogiri'
require 'open-uri'
require 'json'
require 'pstore'

store = PStore.new('schedules.data')
store.transaction do
  store.roots.each do |data|
    puts store[data]
  end
end