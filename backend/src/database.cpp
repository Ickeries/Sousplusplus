#include "database.h"

// Pushs sql data into data vector  when callback is called.
int database::callback(void*data, int argc, char** argv, char** azColName)
{
	vector<json> * results = static_cast<vector<json>*>(data);
	json j;
	for (int i = 0; i < argc; i++)
	{
		j[ azColName[i] ] = string(argv[i] ? argv[i] : "NULL");
	}
	results->push_back(j);

	return 0;
}


// Parse sql statement and returns vector of results as a json if any.
vector<json> database::call(const char * statement)
{
	char* zErrMsg = 0;
	int rc;
	vector<json> data;
	rc = sqlite3_exec(db, statement, callback, &data, &zErrMsg);
	return data;
}

// User test input
int database::main()
{
	int rc = sqlite3_open(file_path, &db);

	while (true)
	{
		string input;
		getline(cin, input);
		vector<json> results = call(input.c_str());
		for (int i = 0; i < results.size(); i++)
		{
			cout << results[i].dump() << endl;
		}
	}
	return 0;

}