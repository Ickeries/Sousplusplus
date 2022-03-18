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
int insert_recipe_ingredient(const char* s, int recipe_id, string recipe_name, string ingredient_name, string ingredient_amount)
{
	sqlite3* db;
	char* zErrMsg;
	int rc = 0;

	rc = sqlite3_open("../database/database.db", &db);

	string sql("INSERT INTO recipe_ingredients (recipe_id, recipe_name, ingredient_name , ingredient_amount) VALUES('" + to_string(recipe_id) + "', '" + recipe_name + "','" + ingredient_name + "', '" + ingredient_amount + "'); ");
	rc = sqlite3_exec(db, sql.c_str(), NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK)
	{
		cout << "Error inserting into table :(\n";
		sqlite3_free(zErrMsg);
	}
	else
		cout << "Successfully inserted into table\n";
	sqlite3_close(db);
	return 0;
}

//Inserts recipe information  :: Step 1
int insert_recipes(const char* s, int recipe_id, string recipe_name, int creator_id, string recipe_description)
{
	sqlite3* db;
	char* zErrMsg;
	int rc = 0;

	rc = sqlite3_open("../database/database.db", &db);

	string sql("INSERT INTO recipes (recipe_id, recipe_name, creator_name , recipe_description) VALUES('" + to_string(recipe_id) + "', '" + recipe_name + "','" + to_string(creator_id) + "', '" + recipe_description + "'); ");

	rc = sqlite3_exec(db, sql.c_str(), NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK)
	{
		cout << "Error inserting into table :(\n";
		sqlite3_free(zErrMsg);
	}
	else
		cout << "Successfully inserted into table\n";
	sqlite3_close(db);

	return 0;
}


//Inserts the directions of the recipe    :: Step 3
int insert_recipe_directions(const char* s, int recipe_id, string recipe_name, string recipe_directions)
{
	sqlite3* db;
	char* zErrMsg;
	int rc = 0;

	rc = sqlite3_open("../database/database.db", &db);

	string sql("INSERT INTO recipes_directions (recipe_id, recipe_name, creator_name , recipe_description) VALUES('" + to_string(recipe_id) + "', '" + recipe_name + "','" + recipe_directions + "'); ");

	rc = sqlite3_exec(db, sql.c_str(), NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK)
	{
		cout << "Error inserting into table :(\n";
		sqlite3_free(zErrMsg);
	}
	else
		cout << "Successfully inserted into recipe_directions table\n";
	sqlite3_close(db);

	return 0;
}


//Inserts new user id and passwords
int insert_new_user(const char* s, int id, string name, string password)
{
	sqlite3* db;
	char* zErrMsg;
	int rc = 0;

	rc = sqlite3_open("../database/database.db", &db);

	string sql("INSERT INTO users (id, name, password) VALUES('" + to_string(id) + "', '" + name + "','" + password + "'); ");

	rc = sqlite3_exec(db, sql.c_str(), NULL, 0, &zErrMsg);

	if (rc != SQLITE_OK)
	{
		cout << "Error inserting into table :(\n";
		sqlite3_free(zErrMsg);
	}
	else
		cout << "Successfully inserted into users table\n";
	sqlite3_close(db);

	return 0;
}

//Will gather all information and send it to its proper table. 
void add_new_recipe(const char* s, vector<json> vec)
{
	int recipe_id, creator_id;
	string recipe_name , recipe_ingredient, recipe_description, recipe_direction, recipe_ingredient_amount;

	// vector will be broken down and assigned its value to the term and sent to its proper table. 

	insert_recipes(database::db_release_path, recipe_id, recipe_name, creator_id, recipe_description);
	insert_recipe_ingredient(database::db_release_path, recipe_id, recipe_name, recipe_ingredient, recipe_ingredient_amount);
	insert_recipe_directions(database::db_release_path, recipe_id, recipe_name, recipe_direction);

}


//@Erik Put this here to test if tables were opening/inserting correctly. will delete later 
/*
int selectData(const char* s)
{
	sqlite3* db;
	char* zErrMsg;
	int rc = 0;

	rc = sqlite3_open("../database/database.db", &db);
	string sql = "SELECT * FROM recipes; ";

	sqlite3_exec(db, sql.c_str(), callback, 0, NULL);

	sqlite3_close(db);
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