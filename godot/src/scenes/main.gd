extends Node

onready var page_explore = $Tabs/Explore
onready var page_recipe = $Tabs/PageRecipe
onready var page_recipe_edit = $Tabs/PageRecipeEdit

onready var previous_page = $Tabs/Explore
onready var current_page = $Tabs/Explore

func _ready():
	Global.connect("enter_return", self, "on_enter_return")
	Global.connect("enter_page", self, "on_enter_page")
	Global.connect("set_page", self, "on_set_page")


func on_enter_page(page_name : String):
	$Fade/Animator.play("fade_to_black")
	yield($Fade/Animator,"animation_finished")
	for page in $Tabs.get_children():
		if page.visible:
			previous_page = page
		page.visible = page.name == page_name
	$Fade/Animator.play("fade_to_clear")

func on_set_page(page_name : String):
	$Fade/Animator.play("fade_to_black")
	yield($Fade/Animator,"animation_finished")
	for page in $Tabs.get_children():
		page.visible = page.name == page_name
	$Fade/Animator.play("fade_to_clear")

func on_enter_return():
	$Fade/Animator.play("fade_to_black")
	yield($Fade/Animator,"animation_finished")
	for page in $Tabs.get_children():
		page.visible = (page == previous_page)
	$Fade/Animator.play("fade_to_clear")
