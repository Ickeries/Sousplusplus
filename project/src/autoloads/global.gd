extends CanvasLayer

var message_loaded = load("res://src/prefabs/message/Message.tscn")

# current user info
var current_id = 0
var current_password = "" 
var current_user = {}
var favorited_recipes = []

func print_message(message : String):
	var message_instance = message_loaded.instance()
	add_child(message_instance)
	message_instance.get_node("Label").text = message

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
