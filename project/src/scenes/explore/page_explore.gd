extends Control

onready var recipe_loaded = load("res://src/prefabs/recipe/Recipe.tscn")
onready var add_new_recipe_loaded = load("res://src/scenes/explore/PageExploreAddNewRecipe.tscn")
onready var category_loaded = load("res://src/scenes/explore/PageExploreCategory.tscn")

onready var screen_effect = $ScreenEffect

onready var search_bar = $SearchBar
onready var search_list = $SearchList/Center/Vertical
onready var filter = $Filter

func _ready():
	Events.emit_signal("show_bottom_menu", true)

func add_category(title : String, items):
	var category_instance = category_loaded.instance()
	search_list.add_child(category_instance)
	category_instance.set_title(title)
	category_instance.add_items(items)


func _on_Filter_filter_applied():
	$Filter/Animator.play_backwards("show")
	screen_effect.visible = false
	_on_SearchBar_search_entered(search_bar.get_text())


func _on_Filter_filter_exited():
	$Filter/Animator.play_backwards("show")
	screen_effect.visible = false




func _on_FilterButton_pressed():
	$ScreenEffect.visible = true
	$Filter/Animator.play("show")


func _on_SearchBar_search_entered(text):
	if search_bar.get_text().length() > 0:
		# If text is being searched
		for category in search_list.get_children():
			category.queue_free()
		var results = Search.get_recipes_by_name(search_bar.get_text())
		var results_filtered = filter.filter_recipes(results)
		add_category("Best Results (%s)" % results_filtered.size(), results_filtered)
	else:
		# If no text is being searched
		pass


func _on_SearchBar_search_edited(text):
	_on_SearchBar_search_entered(text)
