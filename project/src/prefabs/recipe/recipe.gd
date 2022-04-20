extends Control
var recipe_data = {}

var pressed : bool = false
var start_position : = Vector2(0,0)

func set_data(dictionary : Dictionary):
	recipe_data = dictionary
	if dictionary.has("recipe_name"):
		$Title.text = dictionary["recipe_name"]
	if dictionary.has("name"):
		$User.text = "Made by " + dictionary["name"]


func _on_Favorite_pressed():
	$Favorite/Animator.play("press")


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
