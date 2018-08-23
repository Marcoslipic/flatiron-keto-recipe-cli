class CLI
  def start
    list_recipes
  end

  def list_recipes
    puts "Here are some recipes to choose from:"
    puts "1. The Original Zero Carb Pizza Crust"
    puts "2. Keto Butter Chicken"
    puts "Enter the recipe's number, type 'list' to show the recipe list, or type 'exit':"
    get_selection
  end

  def get_selection
    input = nil
    while input != "exit"
      input = gets.chomp.downcase
      case input
      when "1"
        puts "Zero Carb Pizza Crust"
      when "2"
        puts "Butter Chicken"
      when "list"
        list_recipes
      when "exit"
        puts "Goodbye!"
        exit
      else
        puts "Sorry, I didn't understand that."
        list_recipes
      end
    end
  end
end