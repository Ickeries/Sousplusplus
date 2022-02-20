#include "database_users.h"

// Saves database into file_path
void database_users::save_database()
{
	ofstream file;
	file.open(file_path);
	if (file.is_open())
	{
		for (int i = 0; i < database.size(); i++)
		{
			file << database[i].dump() << endl;
		}
		file.close();
	}
}

// Loads database into vector
void database_users::load_database()
{
	ifstream file;
	file.open(file_path);
	if (file.is_open())
	{
		string line;
		while (getline(file, line))
		{
			json user = json::parse(line);
			database.push_back(user);
		}
	}
}

// Prints current database into console
void database_users::print_database()
{
	for (int i = 0; i < database.size(); i++)
	{
		cout << database[i].dump() << endl;
	}
}


// Testing area //
int main()
{

	database_users::load_database();
	database_users::print_database();
	database_users::save_database();
	return 1;
}