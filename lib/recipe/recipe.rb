class KetoRecipe
  attr_accessor :name, :url, :calories, :ingredients, :instructions
  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    self.class.all << self
  end

  def self.all
    @@all
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