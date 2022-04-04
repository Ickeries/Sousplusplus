
#include "database_users.h"

int database_users::login_user(string username, string password){
    string statement = string("SELECT id from user where password =  '" + password 
                               + " and username = '" + username + "';");
    return database::call(statement);
}

json database_users::get_recipes_by_user_id(int user_id){
        string user_id_str = to_string(user_id);
        string statement = string("Select * from recipes where user_id like '%" + user_id_str + "%';"); 
    return database::call(statement);
}