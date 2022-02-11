#include "pipeline.h"

using namespace godot;

void Pipeline::_register_methods() {
    register_method("_process", &Pipeline::_process);
	register_method("check", &Pipeline::check);
}

Pipeline::Pipeline() {
}

Pipeline::~Pipeline() {
    // add your cleanup here
}

void Pipeline::_init() {
    // initialize any variables here
}

void Pipeline::_process(float delta) {
}

String Pipeline::check(String input)
{
	std::string basic_string(input.alloc_c_string());
	godot::String new_string(basic_string.c_str());
	return new_string;
}