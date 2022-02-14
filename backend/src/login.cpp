#include "login.h"

/*
File: login.cpp
Description: Authenticates login information, retrieves current user information, etc.
*/

Login::Login()
{
	// Saves contents of users file into json
	ifstream file(users_path);
	file >> users_json;
	file.close();
}

Login::~Login()
{
	
}


// Authenticates login information
bool Login::authenticate_login_information(string username, string password)
{
	// Loop through array of users and compare usernames and passwords. Return true if match is found.
	int size = users_json["sheets"][0]["lines"].size();
	for (int i = 0; i < size; i++)
	{
		auto user = users_json["sheets"][0]["lines"][i];
		bool verified_username = false;
		bool verified_password = false;
		if (user["name"] == username)
		{
			verified_username = true;
		}
		if (user["password"] == password)
		{
			verified_password = true;
		}
		if (verified_username && verified_password)
			return true;
	}
	return false;
}

bool Login::create_new_account(string username, string password)
{
	return false;
}
