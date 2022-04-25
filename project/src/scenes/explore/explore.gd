extends Control

var recipe_loaded = load("res://src/prefabs/recipe/Recipe.tscn")
var add_new_recipe_loaded = load("res://src/scenes/explore/PageExploreAddNewRecipe.tscn")

onready var category_loaded = load("res://src/scenes/explore/PageExploreCategory.tscn")

onready var items = $Scroll/Center/Vertical/Grid
onready var filter = $Filter

func _ready():
	Events.connect("darken_screen", self, "on_darken_screen")


func add_category(title : String, items):
	var category_instance = category_loaded.instance()
	$Scroll/Center/Vertical.add_child(category_instance)
	category_instance.set_title(title)
	category_instance.add_items(items)


func on_darken_screen(value):
	$Darkness.visible = value

func _on_Explore_visibility_changed():
	Events.emit_signal("show_bottom_menu", true)
	

func _on_FilterButton_pressed():
	$Filter/Animator.play("show")
	$Darkness.visible = true


func _on_Filter_filter_exited():
	$Filter/Animator.play_backwards("show")
	$Darkness.visible = false
	_on_Search_pressed()


func _on_Search_pressed():
	# Get recipes by name
	for category in $Scroll/Center/Vertical.get_children():
		category.queue_free()
	
	var results = Search.get_recipes_by_name($Searchbar.get_text())
	var results_filtered = filter.filter_recipes(results)
	add_category("Best Results (%s)" % results_filtered.size(), results_filtered)
