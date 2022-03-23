extends Node
onready var recipe_page = $PageRecipeEdit

func _ready():
	Global.connect("recipe_page_called", self, "on_recipe_page_called")

func on_recipe_page_called(recipe):
	recipe_page.visible = true
