extends Control

onready var category_loaded = load("res://src/scenes/explore/PageExploreCategory.tscn")

onready var screen_effect = $ScreenEffect

onready var search_bar = $SearchBar
onready var search_list = $SearchList/Center/Vertical
onready var filter = $Filter

func _ready():
	Events.emit_signal("show_bottom_menu", true)

func _on_Filter_filter_applied():
	$Filter/Animator.play_backwards("show")
	screen_effect.visible = false
	_on_SearchBar_search_entered(search_bar.get_text())


func _on_Filter_filter_exited():
	$Filter/Animator.play_backwards("show")
	screen_effect.visible = false




func _on_FilterButton_pressed():
	$ScreenEffect.visible = true
	$Filter/Animator.play("show")

func add_category(title : String, recipes):
	var category_instance = category_loaded.instance()
	search_list.add_child(category_instance)
	category_instance.set_title(title)
	category_instance.set_mode("online")
	category_instance.add_recipes(recipes)


func _on_SearchBar_search_entered(text):
	if search_bar.get_text().length() > 0:
		# If text is being searched
		for category in search_list.get_children():
			category.queue_free()
		
		var results = Search.search_recipes_online(search_bar.get_text())
		var results_filtered = filter.filter_recipes(results)
		add_category("Best Results (%s)" % results_filtered.size(), results_filtered)
	else:
		# If no text is being searched
		pass


func _on_SearchBar_search_edited(text):
	for category in search_list.get_children():
		category.queue_free()
	Events.emit_signal("set_buffering", true)
	$SearchBar/Timer.start()


func _on_Explore_visibility_changed():
	Events.emit_signal("show_bottom_menu", true)
	_on_SearchBar_search_entered(search_bar.get_text())


func _on_Timer_timeout():
	Events.emit_signal("set_buffering", false)
	_on_SearchBar_search_entered(search_bar.get_text())
