extends Node

signal give_image (image)
signal recipe_page_called (recipe)
signal recipe_popup_called (recipe)

var current_user = {}
var current_recipe = ""
var current_ui_button = null

#Try to experiment with different values(Didn't test any of this)
const SENSITIVITY_JUMP := -10
const SENSITIVITY_SLIDE := 15

#This wont be called if a GUI or something else is handling the event
