class CLI
  def start
    category = Category.get_category
    recipe = KetoRecipe.get_recipe(category)
    recipe.print
  end

end