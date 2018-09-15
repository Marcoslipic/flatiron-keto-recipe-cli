require_relative "./concerns/utility"

class KetoRecipe
  extend Utility::ClassMethods
  include Utility::InstanceMethods

  @@all = []
  @@type = "recipe"

  attr_accessor :name, :url, :calories, :ingredients, :instructions

  def self.all
    @@all
  end

  def self.type
    @@type
  end

  def self.start(category_url)
    self.scrape_keto_connect_category(category_url)
    recipe_index = self.menu
    recipe = self.all[recipe_index]
    recipe.print
  end

  def print
    puts "#{self.name}"
    self.scrape_keto_connect_recipe
  end

  def self.scrape_keto_connect_category(url)
    doc = Nokogiri::HTML(open(url))
    posts = doc.css("div.tve_post")

    posts.each do |post|
      name = post.css("span.tve-post-grid-title a").text
      url = post.css("a").attr("href").value
      self.new(name, url)
    end
  end

  def scrape_keto_connect_recipe
    doc = Nokogiri::HTML(open(self.url))
    binding.pry
  end
end