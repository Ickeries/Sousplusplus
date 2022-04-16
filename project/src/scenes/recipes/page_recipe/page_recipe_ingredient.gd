extends Control

func set_data(data):
	if data.has("ingredient_name"):
		$Name.text = data["ingredient_name"]
	#if data.has("ingredient_amount"):
	#	$Amount.text = data["ingredient_amount"]
