#include "search.h"


// Returns a vector of json in string form. autocomplete is on.
string search::get_recipes_by_name(string name, int limit)
{
	string statement = string("Select * from recipes where name like '" + name + "%' limit " + to_string(limit));
	vector<json> results = database::call(statement);
	return database::vector2string(results);
}