extends Control

onready var category_loaded = load("res://src/scenes/explore/PageExploreCategory.tscn")

onready var recipe_list = $Scroll/CenterContainer/List

func add_category(title : String, recipes):
	var category_instance = category_loaded.instance()
	recipe_list.add_child(category_instance)
	category_instance.set_title(title)
	category_instance.set_mode("online")
	category_instance.add_recipes(recipes)


func _on_Button_pressed():
	Events.emit_signal("set_page", "RecipeEdit")


func _on_My_Recipes_pressed():
	for category in recipe_list.get_children():
		category.queue_free()
	$Login.visible = false
	var results = Users.get_user_created_recipes(Global.current_id)
	add_category("Best Results (%s)" % results.size(), results)


func _on_Kitchen_visibility_changed():
	_on_My_Recipes_pressed()
	Events.emit_signal("show_bottom_menu", true)


func _on_Favorites_pressed():
	for category in recipe_list.get_children():
		category.queue_free()
	
	Global.favorited_recipes = Recipe.get_favorited_recipes()
	var results = Search.search_user_favorite_recipes(Global.current_id)
	add_category("Best Results (%s)" % results.size(), results)


func _on_Login_pressed():
	Events.emit_signal("set_page", "Login", "fade_to_black")
