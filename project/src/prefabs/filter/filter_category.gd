tool
extends PanelContainer

var filter_button_loaded = preload("res://src/prefabs/filter/FilterButton.tscn")

export (String) var title = "Null" setget set_title
export (Array, String) var options = [] setget set_options

func set_title(value : String):
	title = value
	if $Vertical/Title != null:
		$Vertical/Title.text = title + " >"

func set_options(value : Array):
	options = value
	
	if $Vertical/List == null:
		return
	
	for option in $Vertical/List.get_children():
		option.queue_free()
	for option in value:
		var filter_button_instance = filter_button_loaded.instance()
		filter_button_instance.text = option + "(0)"
		$Vertical/List.add_child(filter_button_instance)

func get_options():
	return $List.get_children()

func _on_Title_pressed():
	$Vertical/List.visible = !$Vertical/List.visible
