extends PanelContainer


func set_data(data : Dictionary):
	if data.has("text"):
		$Horizontal/Text.set_text(data["text"])

func get_data():
	var data = {}
	data["text"] = $Horizontal/Text.get_text()
	return data
