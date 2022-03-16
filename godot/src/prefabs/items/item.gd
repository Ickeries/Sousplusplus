extends UIButton

var data = {}

func set_data(dictionary : Dictionary):
	data = dictionary
	if dictionary.has("recipe_name"):
		$Title.text = dictionary.recipe_name
	if dictionary.has("recipe_description"):
		$Description.text = dictionary.recipe_description
	if dictionary.has("creator"):
		$Creator.text= dictionary.creator


func _on_Item_pressed():
	if data.has("recipe_id"):
		Global.emit_signal("recipe_page_called", data)
