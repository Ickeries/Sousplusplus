#ifndef DATABASE_H
#define DATABASE_H

#include <iostream>
#include <string>
#include <vector>
#include "include/sqlite3.h"
#include "include/json.hpp"

using namespace std;
using json = nlohmann::json;

namespace database
{
	static const char * db_release_path = "../../database/database.db";
	static const char * db_debug_path = "../database/database.db";
	static sqlite3 * db;
	int callback(void* data, int argc, char** argv, char** azColName);
	json call(string statement);
	bool open();

	//Dont know why this is highlighted when the function is in the class...
	int insert_recipe_ingredient(const char* s, int recipe_id, string recipe_name, string ingredient_name, string ingredient_amount);
}	int insert_recipes(const char* s, int recipe_id, string name, int creator_id, string recipe_description);
	int insert_recipe_directions(const char* s, int recipe_id, string recipe_name, string recipe_directions);
	int insert_new_user(const char* s, int recipe_id, string name, string password);
	void add_new_recipe(const char* s, vector<json> vec);

	//This are here to testing purposing, will delete later
	//int selectData(const char* s);
	//int callback(void* not_Used, int argc, char** argv, char** az_Col_Name);


#endif
//Slide 8 Next Quiz; Slide 34