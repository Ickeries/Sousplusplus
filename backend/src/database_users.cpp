#include "database_users.h"

static int database_users::callback(void* data, int argc, char** argv, char** azColName) {
	int i;
	fprintf(stderr, "%s: ", (const char*)data);

	for (i = 0; i < argc; i++) {
		printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
	}

	printf("\n");
	return 0;
}

// Testing area //
int database_users::main()
{
	sqlite3* db;
	char* zErrMsg = 0;
	int rc;
	char * sql;
	const char* data = "Callback function called";
	rc = sqlite3_open(file_path, &db);

	sql = "Select * from users";

	rc = sqlite3_exec(db, sql, callback, (void*)data, &zErrMsg);
	if (rc != SQLITE_OK)
	{
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
	}
	else
	{
		fprintf(stdout, "Successfull");
	}


	return 0;
}