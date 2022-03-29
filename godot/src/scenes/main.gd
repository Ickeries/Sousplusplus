extends Node

onready var page_explore = $Tabs/Explore
onready var page_recipe = $Tabs/PageRecipe
onready var page_recipe_edit = $Tabs/PageRecipeEdit

var previous_page = null
onready var current_page = $Tabs/Explore

func _ready():
	Global.connect("return_to_explore", self, "on_return_to_explore")
	Global.connect("enter_recipe_edit", self, "on_enter_recipe_edit")
	Global.connect("enter_recipe", self, "on_enter_recipe")
	Global.connect("enter_return", self, "on_enter_return")
	Global.connect("enter_page", self, "on_enter_page")
	Global.connect("set_page", self, "on_set_page")


func on_return_to_explore():
	$Tabs.set_current_tab(page_explore.get_index())


func on_enter_page(page_name : String):
	var page = $Tabs.find_node(page_name)
	if page:
		previous_page = $Tabs.get_current_tab_control()
		$Tabs.set_current_tab(page.get_index())

func on_set_page(page_name : String):
	var page = $Tabs.find_node(page_name)
	if page:
		$Tabs.set_current_tab(page.get_index())

func on_enter_return():
	if current_page:
		$Tabs.set_current_tab(current_page.get_index())


func _on_Explore_pressed():
	current_page = $Tabs/Explore
	on_set_page("Explore")


func _on_Kitchen_pressed():
	current_page = $Tabs/Kitchen
	on_set_page("Kitchen")
