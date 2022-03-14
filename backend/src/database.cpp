#include "database.h"

/*
File: database.cpp
Creator: David Serrano
Description: Logic for database functions.
*/

// Takes a vector of json and returns a string.
string database::vector2string(vector<json> vec)
{
	string result;
	result += "[";
	for (int i = 0; i < vec.size(); i++)
	{
		result += vec[i].dump();
		if (i < vec.size() - 1)
			result += ",";
	}
	result += "]";
	return result;
}

// Places outputs of an sql statement into a vector of json.
int database::callback(void* data, int argc, char** argv, char** azColName)
{
	vector<json>* results = static_cast<vector<json>*>(data);
	json j;
	for (int i = 0; i < argc; i++)
	{
		j[azColName[i]] = string(argv[i] ? argv[i] : "NULL");
	}
	results->push_back(j);
	return 0;
}


// Calls an sql statement.
vector<json> database::call(string statement)
{
	cout << statement << endl;
	char* zErrMsg = 0;
	int rc;
	vector<json> data;
	rc = sqlite3_exec(db, statement.c_str(), callback, &data, &zErrMsg);
	return data;
}


// Starts up the database
void database::initialize()
{
	char* zErrMsg = 0;
	if (sqlite3_open_v2(db_release_path, &db, SQLITE_OPEN_READWRITE, nullptr) == SQLITE_OK)
		return;
	if (sqlite3_open_v2(db_debug_path, &db, SQLITE_OPEN_READWRITE, nullptr) == SQLITE_OK)
		return;

}
