extends Control

var data = {}

func _ready():
	Global.connect("recipe_popup_called", self, "on_recipe_popup_called")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func appear():
	$Animator.play("appear")


func _on_Panel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				visible = false

func on_recipe_popup_called(recipe):
	data = recipe
	appear()

func _on_Open_pressed():
	Global.emit_signal("recipe_page_called", data)
