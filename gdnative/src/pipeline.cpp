#include "pipeline.h"

using namespace godot;

void Pipeline::_register_methods() {
    register_method("_process", &Pipeline::_process);
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