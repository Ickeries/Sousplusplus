#pragma once

#include <iostream>
#include <vector>
#include <string>

#include "include/sqlite3.h"
#include "include/json.hpp"


using namespace std;
using json = nlohmann::json;

namespace database
{
	static sqlite3* db;
	static const char* file_path = "../databases/database.db";
	static int callback(void*data, int argc, char** argv, char** azColName);
	int main();
	vector<json> parse(const char * statement);
};