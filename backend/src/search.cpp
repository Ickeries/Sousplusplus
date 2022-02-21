#include <iostream>
#include <vector>
#include <string>

using namespace std;

vector<string> database = {"apple pie", "cherry pie", "tomato soup", "onion soup", "gingerbread juice"};

// Retrieve string from database
string get_recipe(string name)
{
	for (int i = 0; i < database.size(); i++)
	{
		if (name.compare(database[i]) == 0)
		{
			return database[i];
		}
	}
	// Return nothing if cannot find.
	return "";
}

// Prints the database. Just to help out the user.
void print_database()
{
	for (int i = 0; i < database.size(); i++)
	{
		cout << database[i] << ",";
	}
	cout << endl;
}

int main()
{
	print_database();
	string input;
	string result;
	while (true)
	{
		// Ask user for input
		cout << "Please type your search: ";
		getline(cin, input);
		result = get_recipe(input);
		cout << result << endl;
		if (result.length() > 0)
		{
			cout << "Item found! Returning:\n\n [" << result << "]\n\n" << endl << endl;
		}
		else
		{
			cout << "Item could not be found. Sadness. Try again." << endl;
		}

	}
	return 0;
}