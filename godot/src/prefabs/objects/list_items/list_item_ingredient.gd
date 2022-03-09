extends Control


func set_data(data : Dictionary):
	if data.has("ingredient_name"):
		$HBox/Name.set_text(data["ingredient_name"])
	if data.has("ingredient_amount"):
		$HBox/Amount.set_text(data["ingredient_amount"])
