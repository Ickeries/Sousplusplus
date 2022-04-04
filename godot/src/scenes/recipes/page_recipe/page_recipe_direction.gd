extends PanelContainer


func set_data(data : Dictionary):
	if data.has("recipe_description"):
		$Horizontal/Text.set_text(data["recipe_description"])

func get_data():
	var data = {}
	data["recipe_description"] = $Horizontal/Text.get_text()
	return data
