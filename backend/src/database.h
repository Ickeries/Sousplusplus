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
	int save_recipe_ingredients(json ingredients);
	int save_recipe_ingredient(int recipe_id, string ingredient_name, string ingredient_amount);
	int clear_recipe_ingredients(int id);


	int save_recipe_directions(json directions);
	int save_recipe_direction(int recipe_id, string recipe_description, int step);
	int clear_recipe_directions(int id);


	void save_recipe(json recipe);

	//int insert_recipes(string recipe_id, string name, string creator_id, string recipe_description);
	int insert_recipe_directions(int recipe_description_count, string recipe_id, string recipe_directions);
	int insert_new_user(string recipe_id, string name, string password);

	void remove_row(string table_name, string row, string name);
	void update(string table_name, string col_to_update, string updated_info,string condition_col, string search_condition);
}	
	//This are here to testing purposing, will delete later
	//int selectData(const char* s);
	//int callback(void* not_Used, int argc, char** argv, char** az_Col_Name);


#endif
//Slide 8 Next Quiz; Slide 34