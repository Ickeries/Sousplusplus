extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_texture(new_texture):
	$Image.texture = load(new_texture)

func _on_Button_pressed():
	Events.emit_signal("image_changed", $Image.texture.resource_path)
