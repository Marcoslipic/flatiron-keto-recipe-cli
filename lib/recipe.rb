require "recipe/version"
require "recipe/recipe"
require "recipe/category"

module Recipe
  category = Category.get_category
  recipe = KetoRecipe.get_recipe(category)
  recipe.print
end
