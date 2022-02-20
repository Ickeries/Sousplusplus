#ifndef PIPELINE_H
#define PIPELINE_H

#include <Godot.hpp>
#include <Node.hpp>
#include <string>


namespace godot {

class Pipeline : public Node{
    GODOT_CLASS(Pipeline, Node)
private:
public:
    static void _register_methods();
    Pipeline();
    ~Pipeline();
    void _init(); // our initializer called by Godot
    void _process(float delta);
	String check(String input);
	
	
	bool create_account(String username, String password);
	
	
};
}

#endif