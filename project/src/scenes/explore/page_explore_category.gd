extends VBoxContainer

var recipe_loaded = load("res://src/prefabs/recipe/Recipe.tscn")
var mode = "offline"
func _ready():
	Events.connect("scroll", self, "on_scroll")


func set_title(title : String):
	$Horizontal/Title.set_text(title)

func set_mode(new_mode : String):
	mode = new_mode

func add_recipes(recipes):
	for recipe in recipes:
		var recipe_instance = recipe_loaded.instance()
		recipe_instance.mode = mode
		recipe_instance.call_deferred("load_recipe", recipe)
		$Grid.add_child(recipe_instance)


func _on_Hide_pressed():
	$Grid.visible = !$Grid.visible


func _on_Category_renamed():
	$Horizontal/Title.set_text(name)

func on_scroll(vec : Vector2):
	if vec.x:
		$Grid.rect_position.x += vec.x
