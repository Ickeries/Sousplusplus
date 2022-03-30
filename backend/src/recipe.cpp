#include "recipe.h"


json recipe::get_recipe_by_id(int id)
{
	string statement = string("SELECT * FROM recipes WHERE recipe_id = '" + to_string(id) + "' limit 1;");

	json result = database::call(statement);
	if (result.size() > 0)
		return result[0];
	return json();
}

// Returns all information of a recipe by indexing it's id.
json recipe::get_recipe_by_name(string name)
{
	string statement = string("SELECT * FROM recipes WHERE recipe_name = '" + name + "' limit 1;");
	return database::call(statement);
}

json recipe::get_recipe_ingredients_by_id(int id)
{
	string statement = string("SELECT * FROM recipe_ingredients WHERE recipe_id = '" + to_string(id) + "';");
	return database::call(statement);
}
