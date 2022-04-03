#pragma once
#ifndef SEARCH_H
#define SEARCH_H

#include "database.h"
#include "include/json.hpp"

using namespace std;
using json = nlohmann::json;

namespace search
{
	json get_recipes_by_name(string name);
	json get_recipes_by_filter(string name, json filter);
	json get_recipes_by_filter_include(string name, json filter);

}
#endif