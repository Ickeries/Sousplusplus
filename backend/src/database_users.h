#ifndef DATABASE_USERS_H
#define DATABASE_USERS_H


#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include "json.hpp"

using json = nlohmann::json;
using namespace std;

namespace database_users
{
	static string file_path = "../database/users.txt";
	static vector<json> database;

	void save_database();
	void load_database();
	void print_database();

}

#endif