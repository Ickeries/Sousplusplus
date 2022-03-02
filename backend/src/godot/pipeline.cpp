#include "pipeline.h"

#include "database.h"

using namespace godot;

void Pipeline::_register_methods() {
    register_method("_process", &Pipeline::_process);
	register_method("check", &Pipeline::check);
	
	// Search
	register_method("get_recipes_from_text", &Pipeline::get_recipes_from_text);
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

String Pipeline::get_recipes_from_text(String text)
{
	std::string basic_string(text.alloc_c_string());
	std::string new_string = database::get_recipes_by_text(basic_string);
	godot::String godot_string(new_string.c_str());
	return godot_string;
}