extends Node

func _ready():
	Global.connect("recipe_page_called", self, "on_recipe_page_called")
func on_recipe_page_called(recipe):
	
	$Animator.play("show_recipe_page")


func _on_RecipePage_recipe_page_hide():
	$Animator.play("hide_recipe_page")
