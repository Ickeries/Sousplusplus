#include "database.h"

/*
File: database.cpp
Creator: David Serrano
Description: Logic for database functions.
*/

//Places outputs of an sql statement into a vector of json.
int database::callback(void* data, int argc, char** argv, char** azColName)
{
	json * results = static_cast<json*>(data);
	json j;
	for (int i = 0; i < argc; i++)
	{
		j[azColName[i]] = string(argv[i] ? argv[i] : "NULL");
	}
	results->push_back(j);
	return 0;
} 


// Calls an sql statement.
json database::call(string statement)
{
	json data;
	// If database cannot be opened, return empty json
	if (!open())
		return data;
	char* zErrMsg = 0;
	// Check if statement creates an error
	if (sqlite3_exec(db, statement.c_str(), callback, &data, &zErrMsg) != SQLITE_OK)
		sqlite3_free(zErrMsg);
	sqlite3_close(db);
	return data;
}


// Starts up the database
bool database::open()
{
	char* zErrMsg = 0;
	if (sqlite3_open_v2(db_release_path, &db, SQLITE_OPEN_READWRITE, nullptr) == SQLITE_OK)
		return true;
	if (sqlite3_open_v2(db_debug_path, &db, SQLITE_OPEN_READWRITE, nullptr) == SQLITE_OK)
		return true;
	return false;
}



// Takes data that was provided by the user and inputs into the database :: Step 2
int insert_recipe_ingredient(int recipe_ingredient_count, string recipe_id, string ingredient_name, string ingredient_amount)
{
	for (int i = 0; i < recipe_ingredient_count; ++i)
	{
		string statement("INSERT INTO recipe_ingredients (recipe_id, ingredient_name , ingredient_amount) VALUES('" + recipe_id + "','" + ingredient_name + "', '" + ingredient_amount + "'); ");
		database::call(statement);
	}
	return 0;
}

//Inserts recipe information  :: Step 1
int insert_recipes(string recipe_id, string recipe_name, string creator_id, string recipe_description)
{
	
	string statement("INSERT INTO recipes (recipe_id, recipe_name, creator_name , recipe_description) VALUES('" + recipe_id + "', '" + recipe_name + "','" + creator_id + "', '" + recipe_description + "'); ");
	database::call(statement);
	
	return 0;
}


//Inserts the directions of the recipe    :: Step 3
int insert_recipe_directions(int recipe_description_count, string recipe_id, string recipe_directions)
{
	for (int i = 0; i < recipe_description_count; ++i)
	{
		string statement("INSERT INTO recipes_directions (recipe_id, recipe_description) VALUES('" + recipe_id + "', '" + recipe_directions + "'); ");
			database::call(statement);

	}
	string statement("INSERT INTO recipes_directions (recipe_id, recipe_description) VALUES('" + recipe_id + "', '" + recipe_directions + "'); ");

	database::call(statement);

	return 0;
}


//Inserts new user id and passwords
int insert_new_user(string id, string name, string password)
{

	string statement("INSERT INTO users (id, name, password) VALUES('" + id + "', '" + name + "','" + password + "'); ");

	database::call(statement);

	return 0;
}

//Will gather all information and send it to its proper table. 
void add_new_recipe(json recipe)
{
	int recipe_description_count, recipe_directions_count;

	string recipe_name , recipe_ingredient, recipe_description, recipe_direction, recipe_ingredient_amount,
		recipe_id, creator_id;

	recipe.at("recipe_id") = recipe_id;
	recipe.at("name") = recipe_name;
	recipe.at("creator_id") = creator_id;
	recipe.at("description") = recipe_description;
	recipe_description_count = recipe.at("desciption").size();
	recipe.at("ingredients") = recipe_ingredient;
	recipe_directions_count = recipe.at("ingredients").size();

	insert_recipes(recipe_id, recipe_name, creator_id, recipe_description);
	insert_recipe_ingredient(recipe_description_count, recipe_id, recipe_ingredient, recipe_ingredient_amount);
	insert_recipe_directions(recipe_directions_count, recipe_id, recipe_direction);

}


//@Erik Put this here to test if tables were opening/inserting correctly. will delete later 
/*
int selectData(const char* s)
{
	sqlite3* db;
	char* zErrMsg;
	int rc = 0;

	rc = sqlite3_open("../database/database.db", &db);
	string statement = "SELECT * FROM recipes; ";

	database::call(statement);

	return 0;
}

int callback(void* not_Used, int argc, char** argv, char** az_Col_Name)
{
	for (int i = 0; i < argc; i++)
	{
		cout << az_Col_Name[i] << ": " << argv[i] << endl;
	}
	cout << endl;
	return 0;
}
*/