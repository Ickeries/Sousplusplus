#ifndef DATABASE_H
#define DATABASE_H

#include <iostream>
#include <fstream>
#include <vector>
#include <string>

#include "include/sqlite3.h"
#include "include/json.hpp"
using json = nlohmann::json;
using namespace std;


namespace database{
	static sqlite3* db;
	static const char* file_path = "../databases/database.db";

	int callback(void*data, int argc, char** argv, char** azColName);
	vector<json> call(const char * statement);
	int main();
};

#endif