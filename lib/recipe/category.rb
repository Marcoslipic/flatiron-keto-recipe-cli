require_relative "./concerns/menu"

class Category
  extend Menu

  @@all = []
  @@type = "category"

  attr_accessor :name, :url, :recipes

  def initialize(name, url)
    @name = name
    @url = url
    @recipes = []
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.type
    @@type
  end

  def self.get_category
    self.scrape_all_categories
    self.scrape_all_recipes
    category_index = self.menu("category", self.all)
    category = self.all[category_index]
  end

  def self.scrape_all_categories
    main_url = "https://www.ketoconnect.net/recipes/"
    doc = Nokogiri::HTML(open(main_url))
    rows = doc.css("div.tcb-flex-row") # get the rows that contain the categories
    rows.shift # remove garbage row

    rows.each do |row|
      name = row.css("span.tcb-button-text").text # Returns "All #{category.name} Recipes"
      name.slice!("All ")
      name.slice!(" Recipes")
      url = row.css("a").attr("href").value
      self.new(name, url)
    end
  end

  def add_recipe(recipe)
    self.recipes << recipe
  end

  def self.scrape_all_recipes
    self.all.each do |category|
      doc = Nokogiri::HTML(open(category.url))
      posts = doc.css("div.tve_post")

      posts.each do |post|
        name = post.css("span.tve-post-grid-title a").text
        url = post.css("a").attr("href").value
        recipe = KetoRecipe.new(name, url, category)
        category.add_recipe(recipe)
      end
    end
  end
end