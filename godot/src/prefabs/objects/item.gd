extends Control

var id : int = -1

func set_item(dictionary : Dictionary):
	if dictionary.has("id"):
		id = int(dictionary.id)
	if dictionary.has("name"):
		$Title.text = dictionary.name
	if dictionary.has("description"):
		$Description.text = dictionary.description
	if dictionary.has("creator"):
		$Creator.text= dictionary.creator
