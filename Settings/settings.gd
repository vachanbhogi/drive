extends CanvasLayer

@onready var open_button := $Open_button
@onready var ui := $UI

var opened := false

func _ready() -> void:
	toggle_settings()

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
		$UI/ColorRect/Settings/Music.modulate = "93df9f" if Global.music else "ffffff"
		$UI/ColorRect/Settings/SoundEffects.modulate ="93df9f" if Global.sound_effects else "ffffff"
		$UI/ColorRect/Settings/Particles.modulate = "93df9f" if Global.particles else "ffffff"
	else:
		ui.visible = false
		get_tree().paused = false
		open_button.icon = load("res://assets/ui/icons/gear.svg")

func _on_music_toggled() -> void:
	Global.toggle_music()
	$UI/ColorRect/Settings/Music.modulate = "93df9f" if Global.music else "ffffff"

func _on_sound_effects_toggled() -> void:
	Global.togglet_sound_effects()
	$UI/ColorRect/Settings/SoundEffects.modulate ="93df9f" if Global.sound_effects else "ffffff"

func _on_particles_toggled() -> void:
	Global.toggle_particles()
	$UI/ColorRect/Settings/Particles.modulate = "93df9f" if Global.particles else "ffffff"
