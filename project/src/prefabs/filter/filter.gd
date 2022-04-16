extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_DietButton_pressed():
	$Container/Vertical/Diet/Vertical/List.visible = !$Container/Vertical/Diet/Vertical/List.visible


func _on_CategoryButton_pressed():
	$Container/Vertical/Category/Vertical/List.visible = !$Container/Vertical/Category/Vertical/List.visible

