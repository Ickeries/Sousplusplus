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
	string vector2string(vector<json> vec);
	int callback(void* data, int argc, char** argv, char** azColName);
	vector<json> call(string statement);
	void initialize();
}

#endif