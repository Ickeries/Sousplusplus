#pragma once

#include "database.h"
#include "include/json.hpp"

using namespace std;
using json = nlohmann::json;

namespace recipe
{
	json get_recipe_by_name(string name);
	json get_recipe_ingredients_by_name(string name);
}