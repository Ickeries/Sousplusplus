#include <iostream>

#include "database.h"
#include "search.h"

using namespace std;

int main()
{
	database::initialize();
	while (true)
	{
		string input;
		getline(cin, input);
		cout << search::get_recipes_by_name(input, 1) << endl;
		
	}
	return 0;
}