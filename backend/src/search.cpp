#include "search.h"


// Returns a vector of json in string form. autocomplete is on.
json search::get_recipes_by_name(string name)
{
	string statement = string("Select * from recipes as r left outer join users as u on r.user_id = u.id where recipe_name like '%" + name + "%';"); 
	cout << statement << endl;
	return database::call(statement);
}

//where not EXISTS (Select * from recipe_ingredients as b 
json search::get_recipes_by_filter(string name, json filter)
{
	string statement = string("Select * from recipes as a WHERE a.recipe_name like '");
	statement += name;
	statement += "' ";
	if (filter["exclude"].size() > 0)
	{
		statement += "and not exists(Select * from recipe_ingredients as b where (";
		for (int i = 0; i < filter["exclude"].size(); i++)
		{


			if (i > 0)
			{
				statement += "or ";
			}
			statement += "b.ingredient_name = '";
			statement += filter["exclude"][i];
			statement += "'  ";
		}
		statement += ")";
	
	}
	statement += ";";

	return database::call(statement);
}

json search::get_recipes_by_filter_include(string name, json filter)

{
	string statement = string("Select * from recipes as a WHERE a.recipe_name like '");
	statement += name;
	statement += "' ";
	if (filter["include"].size() > 0)
	{
		statement += "and exists(Select * from recipe_ingredients as b where (";
		for (int i = 0; i < filter["include"].size(); i++)
		{


			if (i > 0)
			{
				statement += "and ";
			}
			statement += "b.ingredient_name = '";
			statement += filter["include"][i];
			statement += "'  ";
		}
		statement += ")";

	}
	statement += ";";

	return database::call(statement);





}
