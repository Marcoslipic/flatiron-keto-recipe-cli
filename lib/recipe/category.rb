require_relative "./concerns/utility"

class Category
  @@all = []
  @@type = "category"

  extend Utility::ClassMethods
  include Utility::InstanceMethods

  attr_accessor :name, :url

  def self.all
    @@all
  end

  def self.type
    @@type
  end

  def self.start
    self.scrape_all_categories
    category_index = self.menu
    category = self.all[category_index]
    puts "Here are all the #{category.name.downcase} recipes:"
    KetoRecipe.start(category.url)
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