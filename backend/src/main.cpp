#include <iostream>

#include "database.h"
#include "search.h"
#include "recipe.h"

using namespace std;

int main()
{
	while (true)
	{
		string input;
		getline(cin, input);
		cout << search::get_recipes_by_name(input, 4).dump(4) << endl;
	}
	return 0;
}