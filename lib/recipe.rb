require "recipe/version"
require "recipe/cli"
require "recipe/recipe"
require "recipe/category"

module Recipe
  CLI::new().start
end
