#pragma once


#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include "json.hpp"

using json = nlohmann::json;
using namespace std;

namespace database_recipes
{
	static string file_path = "../databases/recipes.txt";
	static vector<json> database;

}