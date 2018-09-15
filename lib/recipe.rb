require "recipe/version"
require "recipe/recipe"
require "recipe/category"
require "recipe/menu"

module Recipe
  category = Category.get_category
  recipe = KetoRecipe.get_recipe(category)
  recipe.print
end
