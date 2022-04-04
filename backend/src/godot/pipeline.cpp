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
	register_method("get_recipes_by_filter", &Pipeline::get_recipes_by_filter);
	// Recipe
	register_method("get_recipe_by_id", &Pipeline::get_recipe_by_id);
	register_method("get_recipe_by_name", &Pipeline::get_recipe_by_name);
	register_method("get_recipe_ingredients_by_id", &Pipeline::get_recipe_ingredients_by_id);
	register_method("save_recipe_ingredients", &Pipeline::save_recipe_ingredients);
	register_method("save_recipe", &Pipeline::save_recipe);
}

Pipeline::Pipeline() {
}

Pipeline::~Pipeline() {
    // add your cleanup here
}

void Pipeline::_init() {
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
	json recipes_json = search::get_recipes_by_name(basic_string);
	godot::String godot_string(recipes_json.dump().c_str());
	return godot_string;
}

String Pipeline::get_recipe_by_id(int id)
{
	json recipe_json = recipe::get_recipe_by_id(id);
	godot::String godot_string(recipe_json.dump().c_str());
	return godot_string;
}

String Pipeline::get_recipe_by_name(String name)
{
	std::string basic_string(name.alloc_c_string());
	json recipe_json = recipe::get_recipe_by_name(basic_string);
	godot::String godot_string(recipe_json.dump().c_str());
	return name;
}

String Pipeline::get_recipe_ingredients_by_id(int id)
{
	json ingredients_json = recipe::get_recipe_ingredients_by_id(id);
	godot::String godot_string(ingredients_json.dump().c_str());
	return godot_string;
}


String Pipeline::get_recipes_by_filter(String name, String filter);
{
	
	//json recipes = search::get_recipes_by_filter(name, filter);
	return name;

}

void Pipeline::save_recipe(String recipe)
{
	json recipe_json = json::parse(recipe.alloc_c_string());
	database::save_recipe(recipe_json);
}

void Pipeline::save_recipe_ingredients(String recipe_ingredients)
{

	json recipe_ingredients_json = json::parse(recipe_ingredients.alloc_c_string());
	database::save_recipe_ingredients(recipe_ingredients_json);

}