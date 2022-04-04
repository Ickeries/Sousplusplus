#include "recipe.h"


json recipe::get_recipe_ingredients_by_id(int id)
{
	string statement = string("SELECT * FROM recipe_ingredients WHERE recipe_id = " + to_string(id) + ";");
	json results = database::call(statement);
	if (results.dump() != "null")
	{
		return results;
	}
	return json::parse("[]");
}

json recipe::get_recipe_directions_by_id(int id)
{
	string statement = string("SELECT * FROM recipes_directions WHERE recipe_id = " + to_string(id) + ";");
	json results = database::call(statement);
	if (results.dump() != "null")
	{
		return results;
	}
	return json::parse("[]");
}



json recipe::get_recipe_by_id(int id)
{
	string statement = string("SELECT * FROM recipes WHERE recipe_id = '" + to_string(id) + "' limit 1;");
	json results = database::call(statement);
	if (results.size() > 0)
	{
		json result = results[0];
		result["ingredients"] = get_recipe_ingredients_by_id(id);
		result["directions"] = get_recipe_directions_by_id(id);
		return result;
	}
	return json::parse("[]");
}




// Returns all information of a recipe by indexing it's id.
json recipe::get_recipe_by_name(string name)
{
	string statement = string("SELECT * FROM recipes WHERE recipe_name = '" + name + "' limit 1;");
	json results = database::call(statement);
	cout << results.dump() << endl;

	return results;
}