#ifndef DATABASE_USERS_H
#define DATABASE_USERS_H


#include <iostream>
#include <fstream>
#include <cstdlib>
#include <stdio.h>
#include <vector>
#include <string>

#include "sqlite3.h"
using namespace std;

namespace database_users
{
	static const char * file_path = "../databases/database.db";
	int main();
	
	static int callback(void* data, int argc, char** argv, char** azColName);
	
}

#endif