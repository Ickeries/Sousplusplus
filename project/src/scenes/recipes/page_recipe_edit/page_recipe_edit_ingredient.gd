extends Control


func load_ingredient(data : Dictionary):
	if data.has("ingredient_name"):
		$Horizontal/Title.set_text(data["ingredient_name"])
	if data.has("ingredient_amount"):
		$Horizontal/Amount.set_text(data["ingredient_amount"])
	if data.has("ingredient_unit"):
		$Horizontal/Unit.set_text(data["ingredient_unit"])

func get_data():
	var data = {}
	data["ingredient_name"] = $Horizontal/Title.get_text()
	data["ingredient_amount"] = int( $Horizontal/Amount.get_text() )
	data["ingredient_unit"] = $Horizontal/Unit.get_text()
	return data


func _on_X_pressed():
	queue_free()


func _on_IncreaseAmount_pressed():
	$Horizontal/Amount.text = str( clamp( int($Horizontal/Amount.text) + 1, 0, 100) )


func _on_DecreaseAmount_pressed():
	$Horizontal/Amount.text = str( clamp( int($Horizontal/Amount.text) - 1, 0, 100) )
	
