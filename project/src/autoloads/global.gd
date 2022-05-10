extends CanvasLayer

var message_loaded = load("res://src/prefabs/message/Message.tscn")

# current user info
var current_id = 0
var current_password = "" 
 
var current_user = {}
var favorited_recipes = []
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

func print_message(message : String):
	var message_instance = message_loaded.instance()
	add_child(message_instance)
	message_instance.get_node("Label").text = message

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
