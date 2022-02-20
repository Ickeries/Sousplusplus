#include "pipeline.h"

#include "database_user.cpp"


using namespace godot;

void Pipeline::_register_methods() {
    register_method("_process", &Pipeline::_process);
	register_method("check", &Pipeline::check);
	register_method("create_account", &Pipeline::create_account);
}

Pipeline::Pipeline() {
	database_user::initialize();
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

bool Pipeline::create_account(String username, String password)
{
	std::string username_c(username.alloc_c_string());
	std::string password_c(password.alloc_c_string());
	database_user::create_new_user(username_c, password_c);
	
	
	return true;

}