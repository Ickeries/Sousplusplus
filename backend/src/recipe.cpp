#include "recipe.h"


// Returns all information of a recipe by indexing it's id.
string recipe::get_recipe_by_name(string name)
{
	string statement = string("SELECT * FROM recipes WHERE recipe_name = '" + name + "' limit 1;");
	vector<json> results = database::call(statement);
	

	return database::vector2string(results);
}

string recipe::get_recipe_ingredients_by_name(string name)
{
	string statement = string("SELECT * FROM recipe_ingredients WHERE recipe_name = '" + name + "';");
	vector<json> results = database::call(statement);
	return database::vector2string(results);
}
