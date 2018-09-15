require_relative "./concerns/utility"

class KetoRecipe
  extend Utility::ClassMethods

  @@all = []
  @@type = "recipe"

  attr_accessor :name, :url, :ingredients, :instructions

  def initialize(name, url)
    @name = name
    @url = url
    @ingredients = []
    @instructions = []
    self.class.all << self
  end

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
    self.scrape_keto_connect_recipe
    puts "\n#{self.name}"
    puts "\nIngredients:"
    self.ingredients.each do |ingredient|
      puts clean_ingredient(ingredient)
    end
    puts "\nInstructions:"
    self.instructions.each_with_index do |instruction, index|
      puts "#{index + 1}. #{instruction}"
    end
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
    ingredients_data = doc.css("li.wprm-recipe-ingredient")
    ingredients_data.each do |ingredient|
      amount = ingredient.css("span.wprm-recipe-ingredient-amount").text
      unit = ingredient.css("span.wprm-recipe-ingredient-unit").text
      name = ingredient.css("span.wprm-recipe-ingredient-name").text
      notes = ingredient.css("span.wprm-recipe-ingredient-notes")
      if notes
        notes = "#{notes.text}"
      end
      self.ingredients.push("#{amount} #{unit} #{name} #{notes}")
    end

    instructions_data = doc.css("li.wprm-recipe-instruction")
    instructions_data.each do |instruction|
      self.instructions.push(instruction.text)
    end
  end

  def clean_ingredient(ingredient)
    while ingredient.match(/\s\s/)
      ingredient.gsub!(/\s\s/, " ")
    end
    ingredient.strip
  end
end