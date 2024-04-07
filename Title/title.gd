extends Control

var colors = [
	Color.html('539e7b'),
	Color.html('e9c46a'),
	Color.html('acedff'),
	Color.html('947bd3'),
	Color.html('e54b4b')
]
var current_color_index = 0
var current_fog_color = colors[0]
var target_color = colors[1]

var transition_duration = 3.0
var transition_timer = 0.0

@onready var background := $Background

func _process(delta: float) -> void:
	if transition_timer < transition_duration:
		transition_timer += delta
		var t = transition_timer / transition_duration
		var current_color = Color(
			lerp(current_fog_color.r, target_color.r, t),
			lerp(current_fog_color.g, target_color.g, t),
			lerp(current_fog_color.b, target_color.b, t),
			lerp(current_fog_color.a, target_color.a, t)
		)
		background.color = current_color
	else:
		transition_timer = 0.0
		current_color_index = (current_color_index + 1) % colors.size()
		current_fog_color = target_color
		target_color = colors[current_color_index]


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file('res://World/world.tscn')
