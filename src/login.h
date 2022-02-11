#pragma once

/*
File: login.h
Description: Authenticates login information
*/

#include <string>

using namespace std;

class Login{
	
public:
	Login();
	~Login();
	
	bool authenticate_login_information(string username, string password);
	bool create_new_account(string username, string password);
	
};