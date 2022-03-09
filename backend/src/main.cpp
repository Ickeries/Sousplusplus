#include <iostream>

#include "database.h"
#include "search.h"
#include "recipe.h"

using namespace std;

int main()
{
	database::initialize();
	while (true)
	{
		string input;
		getline(cin, input);
		cout << recipe::get_recipe_by_name(input) << endl;
		
	}
	return 0;
}