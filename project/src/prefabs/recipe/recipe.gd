extends Control

onready var title = $Title
onready var user = $User
onready var favorite_animator = $Favorite/Animator

var mode : String = "offline"
var recipe_id = -1
var user_name : String = ""
var pressed : bool = false
var start_position : = Vector2(0,0)

var data = {}

func _ready():
	load_recipe(data)

func load_recipe(data : Dictionary):
	if data.has("recipe_id"):
		recipe_id = data["recipe_id"]
		user.text = "Made by " + str(Users.get_user_name_by_id(data.user_id))
	if data.has("recipe_name"):
		title.text = data["recipe_name"]
	if data.has("recipe_image") and data.recipe_image:
		$Image.texture = load("res://assets/images/%s" % [data.recipe_image])
	if Global.favorited_recipes.has(data.recipe_id):
		$Favorite/Button.set_pressed_no_signal(true)
		favorite_animator.play("press")
	else:
		favorite_animator.play("unpress")
		$Favorite/Button.set_pressed_no_signal(false)
	pass

func get_recipe_name():
	return title.text

func get_user_name():
	return user_name

func _on_Favorite_pressed(event):
	favorite_animator.play("press")


func _on_Recipe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_position = event.position
				pressed = true
			else:
				pressed = false
				if event.position.distance_to(start_position) < 10.0:
					Events.emit_signal("set_page", "RecipeEdit", "fade_to_black")
					Events.emit_signal("set_recipe", self)
	
	if event is InputEventMouseMotion:
		if pressed:
			Events.emit_signal("scroll", event.relative)


func _on_Favorite_toggled(button_pressed):
	if button_pressed:
		Recipe.add_favorite_recipe(recipe_id)
	else:
		Recipe.remove_favorite_recipe(recipe_id)	
	favorite_animator.play("press")


func _on_Recipe_visibility_changed():
	pressed = false


func _on_Favorite_Button_toggled(button_pressed):
	if button_pressed:
		Recipe.add_favorite_recipe(recipe_id)
		favorite_animator.play("press")
		
	else:
		Recipe.remove_favorite_recipe(recipe_id)
		favorite_animator.play("unpress")
