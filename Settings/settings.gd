extends CanvasLayer

@onready var open_button := $Open_button
@onready var ui := $UI

var opened := false

func _ready() -> void:
	# Initialize UI elements based on global settings
	$UI/ColorRect/Settings/Music.button_pressed = Global.settings["music"]
	$UI/ColorRect/Settings/SoundEffects.button_pressed = Global.settings["sound_effects"]
	$UI/ColorRect/Settings/Particles.button_pressed = Global.settings["particles"]

func _on_open_pressed() -> void:
	toggle_settings()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_settings()

func toggle_settings() -> void:
	opened = !opened
	if opened:
		ui.visible = true
		get_tree().paused = true
		open_button.icon = load("res://assets/ui/icons/close.svg")
	else:
		ui.visible = false
		get_tree().paused = false
		open_button.icon = load("res://assets/ui/icons/gear.svg")

func _on_music_toggled(button_pressed: bool) -> void:
	Global.settings["music"] = button_pressed

func _on_sound_effects_toggled(button_pressed: bool) -> void:
	Global.settings["sound_effects"] = button_pressed

func _on_particles_toggled(button_pressed: bool) -> void:
	Global.settings["particles"] = button_pressed
