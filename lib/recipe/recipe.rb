class KetoRecipe < Keto
  attr_accessor :calories, :ingredients, :instructions
  @@type = "recipe"
  
  def self.print_all
    self.all.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"
    end
  end

  def self.start
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
    # binding.pry
  end
end