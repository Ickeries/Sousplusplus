#ifndef DATABASE_USERS_H
#define DATABASE_USERS_H


#include <iostream>
#include <string>
#include <vector>

#include "database.h"
#include "include/sqlite3.h"
#include "include/json.hpp"

using namespace std;
using json = nlohmann::json;



namespace database_users
{
 json login_user(string username, string password);
 json get_recipes_by_user_id(int user_id);

 json get_user_name(int user_id);


}

#endif