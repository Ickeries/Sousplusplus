extends Control

onready var category_loaded = load("res://src/scenes/explore/PageExploreCategory.tscn")

onready var my_recipe_list = $Tabs/MyRecipes/Scroll/CenterContainer/List
onready var favorites_list = $Tabs/Second/Scroll/CenterContainer/List
onready var login = $Tabs/Second/Login

func add_category(title : String, recipes, target):
	var category_instance = category_loaded.instance()
	target.add_child(category_instance)
	category_instance.set_title(title)
	category_instance.set_mode("online")
	category_instance.add_recipes(recipes)


func _on_Kitchen_visibility_changed():
	if Global.current_id == -1:
		$PleaseLogIn.visible = true
		$Tabs.visible = false
	else:
		$PleaseLogIn.visible = false
		$Tabs.visible = true
		$Tabs.set_current_tab(0)
		$Tabs/First/WelcomeBack.text = "Welcome back, %s!" % [Global.current_user_name]
	Events.emit_signal("show_bottom_menu", true)


func _on_AddNewRecipe_pressed():

	Events.emit_signal("new_recipe")
	Events.emit_signal("set_page", "RecipeEdit", "fade_to_black")


func _on_MyFavorites_pressed():
	$Tabs.set_current_tab(1)

# Favorites
func _on_Second_visibility_changed():
	for category in favorites_list.get_children():
		category.queue_free()
	var results = Search.search_user_favorite_recipes(Global.current_id)
	add_category("", results, favorites_list)


func _on_PleaseLogIn_pressed():
	Events.emit_signal("set_page", "Login", "fade_to_black")


func _on_MyRecipes_visibility_changed():
	for category in my_recipe_list.get_children():
		category.queue_free()
	var results = Users.get_user_created_recipes(Global.current_id)
	add_category("", results, my_recipe_list)


func _on_MyRecipes_pressed():
	$Tabs.set_current_tab(2)


func _on_ReturnToFirst_pressed():
	$Tabs.set_current_tab(0)
