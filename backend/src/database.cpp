#include "database.h"

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

vector<json> database::call(const char* statement)
{
	char* zErrMsg = 0;
	int rc;
	vector<json> data;
	rc = sqlite3_exec(db, statement, callback, &data, &zErrMsg);
	return data;
}

string database::get_recipes_by_text(string text)
{
	string input = string("Select * from recipes where name like '" + text + "%'");
	vector<json> results = call(input.c_str());
	return vector2string(results);
}



void database::initialize()
{
	char* zErrMsg = 0;
	int rc;
	rc = sqlite3_open(db_name, &db);
}


int main()
{
	database::initialize();
	return 0;
}
