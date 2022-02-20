extends Node

signal give_image (image)

var current_user = {}

func _ready():
	pass

func _on_Explore_pressed():
	get_tree().change_scene("res://src/scenes/explore/Explore.tscn")


func _on_MyKitchen_pressed():
	get_tree().change_scene("res://src/scenes/kitchen/Kitchen.tscn")
