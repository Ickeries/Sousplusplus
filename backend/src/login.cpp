#include "login.h"

/*
File: login.cpp
Description: Authenticates login information, retrieves current user information, etc.
*/

Login::Login()
{
	
}

Login::~Login()
{
	
}


// Check /database/users/login.txt to see if contains the necessary login information
bool Login::authenticate_login_information(string username, string password)
{
	// Opens the users json file and places it into built in json class
	ifstream file("../database/users/users.txt");
	json j;
	file >> j;

	// Loop through array of users and compare usernames and passwords. Return true if match is found.
	int size = j["sheets"][0]["lines"].size();
	for (int i = 0; i < size; i++)
	{
		bool verified_username = false;
		bool verified_password = false;
		if (j["sheets"][0]["lines"][i]["name"] == username)
		{
			verified_username = true;
		}
		if (j["sheets"][0]["lines"][i]["password"] == password)
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
