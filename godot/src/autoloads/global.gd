extends Node

var message_loaded = load("res://src/prefabs/message/Message.tscn")


signal give_image (image)
signal recipe_page_called (recipe)
signal recipe_popup_called (recipe)

signal return_to_explore ()
signal enter_recipe_edit(data)
signal enter_recipe(data)

signal enter_page(page_name)
signal set_page(page_name)
signal enter_return()

signal update_data(data)

var current_user = {}
var current_recipe = ""
var current_ui_button = null

var data_template = {
"recipe_id" : -1,
"recipe_name" : "",
"creator_id" : 1,
"recipe_description" : "",
"tags" : [],
"instructions" : [],
}

var data = {}


func get_data_template():
	return data_template.duplicate()

func print_message(message : String, pos : Vector2):
	var message_instance = message_loaded.instance()
	add_child(message_instance)
	message_instance.get_node("Label").text = message
	message_instance.rect_position = pos

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
