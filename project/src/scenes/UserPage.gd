extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_Logout_pressed():
	Global.current_id = -1
	Global.current_password = "" 
	Global.current_user_name = ""
	Global.current_user = {}
	Global.favorited_recipes = []
	Events.emit_signal("set_page", "Explore", "fade_to_black")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
