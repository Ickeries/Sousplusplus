#include "pipeline.h"

#include "database.h"
#include "recipe.h"
#include "search.h"

using namespace godot;

void Pipeline::_register_methods() {
    register_method("_process", &Pipeline::_process);
	register_method("check", &Pipeline::check);

	// Search
	register_method("get_recipes_by_name", &Pipeline::get_recipes_by_name);
	// Recipe
	register_method("get_recipe_by_name", &Pipeline::get_recipe_by_name);
	register_method("get_recipe_ingredients_by_name", &Pipeline::get_recipe_ingredients_by_name);
}

Pipeline::Pipeline() {
}

Pipeline::~Pipeline() {
    // add your cleanup here
}

void Pipeline::_init() {
	database::initialize();
}

void Pipeline::_process(float delta) {
}

String Pipeline::check(String input)
{
	std::string basic_string(input.alloc_c_string());
	godot::String new_string(basic_string.c_str());
	return new_string;
}

String Pipeline::get_recipes_by_name(String name)
{
	std::string basic_string(name.alloc_c_string());
	std::string new_string = search::get_recipes_by_name(basic_string, 6);
	godot::String godot_string(new_string.c_str());
	return godot_string;
}

String Pipeline::get_recipe_by_name(String name)
{
	std::string basic_string(name.alloc_c_string());
	std::string new_string = recipe::get_recipe_by_name(basic_string);
	godot::String godot_string(new_string.c_str());
	return godot_string;
}

String Pipeline::get_recipe_ingredients_by_name(String name)
{
	std::string basic_string(name.alloc_c_string());
	std::string new_string = recipe::get_recipe_ingredients_by_name(basic_string);
	godot::String godot_string(new_string.c_str());
	return godot_string;
}