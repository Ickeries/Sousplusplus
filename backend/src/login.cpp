

#include <string>
#include <fstream>
#include "json.hpp"

using json = nlohmann::json;
using namespace std;
namespace login
{

string users_path = "users.txt";

json users_json;

void initialize()
{
	ifstream file(users_path);
	if (file.is_open())
	{
		file >> users_json;
		file.close();
	}
}

bool save_users_json()
{
	ofstream file;
	file.open(users_path);
	file << users_json.dump();
	file.close();
	return true;
}

//Authenticates login information
std::string authenticate_login_information(string username, string password)
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
			return user.dump();
	}
	
	return "";
}


bool create_new_account(string username, string password)
{
	
	if (authenticate_login_information(username, password).empty())
	{
		json new_user;
		new_user["id"] = users_json["sheets"][0]["lines"].size();
		new_user["name"] = username;
		new_user["password"] = password;
		//
		users_json["sheets"][0]["lines"].push_back(new_user);
		if (save_users_json() == false)
			return false;
		return true;
	}
	return false;
}



}