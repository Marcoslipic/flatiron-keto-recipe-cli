class CLI
  def start
    KetoRecipe.scrape_keto_connect_category('http://www.ketoconnect.net/main-dishes/')
    menu
  end

  def list_recipes
    puts "Here are some recipes to choose from:"
    KetoRecipe.all.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"
    end
  end

  def menu
    list_recipes
    puts "Enter the recipe's number, type 'list' to show the recipe list, or type 'exit':"
    input = nil
    while input != "exit"
      input = gets.chomp.downcase
      if input.to_i > 0
        index = input.to_i - 1
        recipe = KetoRecipe.all[index]
        # binding.pry
        puts "#{input}. #{recipe.name}"
        recipe.scrape_keto_connect_recipe
      elsif input == "list"
        list_recipes
      elsif input == "exit"
        puts "Goodbye!"
        exit
      else
        puts "Sorry, I didn't understand that."
        list_recipes
      end
    end
  end
end