extends Node


# File: autoload_events.gd
# Description: Global signal list


# Changes the current page. 
#page_name: the name of page to transition_to
#transition_type: the transition animation to play
#remember_previous_page: true when you want to remember the last page you went to
signal set_page(page_name, transition_animation, remember_previous_page)
signal return_to_previous_page(transition_animation)


# Set the visibility of the menu bar.
signal show_bottom_menu(value)
signal darken_screen(value)

signal set_recipe(recipe_data)

# Scrolls any scroll boxes
signal scroll(vec)
