extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_texture(new_texture):
	texture = load(new_texture)

func _on_Button_pressed():
	$Animator.play("pressed")
	Events.emit_signal("image_changed", texture.resource_path)
