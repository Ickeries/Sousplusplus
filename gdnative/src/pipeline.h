#ifndef PIPELINE_H
#define PIPELINE_H

#include <Godot.hpp>
#include <Node.hpp>

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
};

}

#endif