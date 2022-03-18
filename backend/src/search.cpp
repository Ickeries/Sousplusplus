#include "search.h"


// Returns a vector of json in string form. autocomplete is on.
json search::get_recipes_by_name(string name, int limit)
{
	string statement = string("Select * from recipes where recipe_name like '%" + name + "%' limit " + to_string(limit) + ";"); 
	return database::call(statement);
}