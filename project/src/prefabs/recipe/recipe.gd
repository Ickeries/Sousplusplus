extends Control

onready var title = $Title
onready var user = $User
onready var favorite_animator = $Favorite/Animator

var recipe_data = {}

var pressed : bool = false
var start_position : = Vector2(0,0)



func set_data(dictionary : Dictionary):
	recipe_data = dictionary
	if dictionary.has("recipe_name"):
		title.text = dictionary["recipe_name"]
	if dictionary.has("name"):
		user.text = "Made by " + dictionary["name"]


func _on_Favorite_pressed(event):
	favorite_animator.play("press")
	Global.print_message("Added to favorites!", get_global_mouse_position())


func _on_Recipe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_position = event.position
				pressed = true
			else:
				pressed = false
				if event.position.distance_to(start_position) < 10.0:
					Events.emit_signal("set_recipe", recipe_data)
					Events.emit_signal("set_page", "Recipe")
	
	if event is InputEventMouseMotion:
		if pressed:
			Events.emit_signal("scroll", event.relative)


func _on_Favorite_toggled(button_pressed):
	if button_pressed:
		Recipe.add_favorite_recipe(recipe_data['recipe_id'])
	else:
		Recipe.remove_favorite_recipe(recipe_data['recipe_id'])	
	favorite_animator.play("press")
