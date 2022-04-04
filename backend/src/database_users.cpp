
#include "database_users.h"

json database_users::login_user(string username, string password) {
    string statement = string("SELECT id from users where password = '" + password
        + "' and name = '" + username + "';");

    cout << statement << endl;
    json results = database::call(statement);
    cout << results.dump() << endl;
    if (results.size() > 0)
    {
        return results[0];
    }
    return json::parse("[]");
}

json database_users::get_recipes_by_user_id(int user_id) {
    string user_id_str = to_string(user_id);
    string statement = string("Select * from recipes as r left outer join users as u on r.user_id = u.id where user_id like '%" + user_id_str + "%';");
    return database::call(statement);
}

json database_users::get_user_name(int user_id)
{
    string statement = string("Select name from users where id = " + to_string(user_id) + ";");
    json results = database::call(statement);
    if (results.size() > 0)
    {
        return results[0];
    }
    return json::parse("[]");
}
