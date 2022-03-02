#pragma once
#ifndef SEARCH_H
#define SEARCH_H

#include "database.h"
#include "include/json.hpp"

using namespace std;
using json = nlohmann::json;

namespace search
{
	string get_recipes_by_name(string name, int limit);


}
#endif