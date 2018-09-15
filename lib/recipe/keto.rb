require_relative "./concerns/menu"

class Keto
  extend Menu
  
  attr_accessor :name, :url
  @@all = []
  @@type = nil

  def initialize(name, url)
    @name = name
    @url = url
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.type
    @@type
  end

  def self.print_all
    self.all.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name}"
    end
  end
end