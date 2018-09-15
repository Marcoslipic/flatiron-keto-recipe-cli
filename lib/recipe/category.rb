require_relative "./concerns/menu"

class Category
  @@all = []
  @@type = "category"

  extend Menu

  attr_accessor :name, :url

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

  def self.get_category
    self.scrape_all_categories
    category_index = self.menu
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
end