class CLI
  def start
    KetoRecipe.scrape_keto_connect_category('http://www.ketoconnect.net/main-dishes/')
    KetoRecipe.start
  end

end