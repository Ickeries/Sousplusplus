#pragma once

/*
File: login.h
Description: Authenticates login information
*/

#include <fstream>

#include "json.hpp"

using namespace std;
using json = nlohmann::json;
class Login{
	
public:
	Login();
	~Login();
	
	bool authenticate_login_information(string username, string password);
	bool create_new_account(string username, string password);
private:
	string users_path = "../database/users/users.txt";
	json users_json;
};