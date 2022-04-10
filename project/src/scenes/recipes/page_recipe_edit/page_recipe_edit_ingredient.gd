extends Control

var id = -1

func set_data(data : Dictionary):
	if data.has("recipe_id"):
		id = int(data["recipe_id"])
	if data.has("ingredient_name"):
		$Horizontal/Name.set_text(data["ingredient_name"])
	if data.has("ingredient_amount"):
		$Horizontal/Amount.set_text(data["ingredient_amount"])

func get_data():
	var data = {}
	data["recipe_id"] = id
	data["ingredient_name"] = $Horizontal/Name.get_text()
	data["ingredient_amount"] = $Horizontal/Amount.get_text()
	return data

func _on_Remove_pressed():
	queue_free()
