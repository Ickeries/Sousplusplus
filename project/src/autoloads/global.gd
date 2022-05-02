extends CanvasLayer

var message_loaded = load("res://src/prefabs/message/Message.tscn")

# current user info
var current_id = 420
var current_password = "" 
 
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

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
onready var db = SQLite.new()
var db_name = "database.db"


func _ready():
	db.path = db_name

func query_single(statement : String):
	db.query(statement)
	if db.query_result.size() > 0:
		return db.query_result[0]
	return null

func query(statement : String):
	db.query(statement)
	return db.query_result.duplicate()

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
