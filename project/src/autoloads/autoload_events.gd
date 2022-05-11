extends Node


# File: autoload_events.gd
# Description: Global signal list


# Changes the current page. 
#page_name: the name of page to transition_to
#transition_type: the transition animation to play
#remember_previous_page: true when you want to remember the last page you went to
signal set_page(page_name, transition_animation, remember_previous_page)
signal return_to_previous_page(transition_animation)

signal image_changed (image_path)
signal image_confirmed (image_path)
# Set the visibility of the menu bar.
signal show_bottom_menu(value)
signal darken_screen(value)
signal play_transition(transition_animation)
signal transition_finished()
signal set_recipe(recipe_data)
signal new_recipe()
signal loading_started()
signal loading_finished()
# Scrolls any scroll boxes
signal scroll(vec)

signal set_buffering(value)
