extends Control


func set_data(data : Dictionary):
	if data.has("ingredient_name"):
		$Horizontal/Name.set_text(data["ingredient_name"])
	if data.has("ingredient_amount"):
		$Horizontal/Amount.set_text(data["ingredient_amount"])



func _on_Remove_pressed():
	queue_free()
