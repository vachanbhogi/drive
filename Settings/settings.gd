extends CanvasLayer

@onready var openButton := $Open_button
@onready var ui := $UI
@onready var musicSettings := $UI/ColorRect/Settings/Music
@onready var soundEffectsSettings := $UI/ColorRect/Settings/SoundEffects
@onready var particlesSettings := $UI/ColorRect/Settings/Particles

var isOpened := false

func _ready() -> void:
	toggleSettings()
	hideUI()

func _on_open_pressed() -> void:
	toggleSettings()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggleSettings()

func toggleSettings() -> void:
	isOpened = !isOpened
	if isOpened:
		showUI()
	else:
		hideUI()

func showUI() -> void:
	ui.show()
	get_tree().paused = true
	openButton.icon = load("res://assets/ui/icons/close.svg")
	updateSettingsColors()

func hideUI() -> void:
	ui.hide()
	get_tree().paused = false
	openButton.icon = load("res://assets/ui/icons/gear.svg")

func updateSettingsColors() -> void:
	musicSettings.modulate = "93df9f" if Global.music else "ffffff"
	soundEffectsSettings.modulate ="93df9f" if Global.sound_effects else "ffffff"
	particlesSettings.modulate = "93df9f" if Global.particles else "ffffff"

func _on_music_toggled() -> void:
	Global.toggle_music()
	updateSettingsColors()

func _on_sound_effects_toggled() -> void:
	Global.togglet_sound_effects()
	updateSettingsColors()

func _on_particles_toggled() -> void:
	Global.toggle_particles()
	updateSettingsColors()
