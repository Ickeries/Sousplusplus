#ifndef PIPELINE_H
#define PIPELINE_H

#include <Godot.hpp>
#include <Node.hpp>
#include <string>
#include <vector>

#include "../include/json.hpp"

using json = nlohmann::json;

namespace godot {

class Pipeline : public Node{
    GODOT_CLASS(Pipeline, Node)
public:
    static void _register_methods();
    Pipeline();
    ~Pipeline();
    void _init(); // our initializer called by Godot
    void _process(float delta);
	String check(String input);
	String get_recipes_by_filter(String name, String filter);
	String get_recipes_by_name(String name);
	String get_recipe_by_id(int id);
	String get_recipe_by_name(String name);
	String get_recipe_ingredients_by_id(int id);


	void save_recipe(String recipe);
	void save_recipe_ingredients(String recipe_ingredients);
	
};
}

#endif