extends Node

signal music_changed

var music: bool
var sound_effects: bool
var particles: bool

func _ready():
	music = true
	sound_effects = true
	particles = true

func toggle_music() -> void:
	music = !music
	emit_signal('music_changed')

func togglet_sound_effects() -> void:
	sound_effects = !sound_effects

func toggle_particles() -> void:
	particles = !particles
