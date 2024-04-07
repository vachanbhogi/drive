extends Node

@export var player: RigidBody3D

var direction = Vector3.FORWARD
const MAX_POINTS = 5
const ADD_THRESHOLD_SQUARED = 15000
const BATCH_SIZE = 3

@onready var path: Path3D = $Path

func _physics_process(_delta: float) -> void:
	var lastPointCount = path.curve.get_point_count()
	if player.global_position.distance_squared_to(path.curve.get_point_position(lastPointCount - 1)) < ADD_THRESHOLD_SQUARED:
		_add_road()

func _add_road():
	var excessPoints = path.curve.get_point_count() - MAX_POINTS
	for x in range(excessPoints):
		path.curve.remove_point(0)

	var lastPoint = path.curve.get_point_position(path.curve.get_point_count() - 1)
	for x in range(BATCH_SIZE):
		var rotationAngle = deg_to_rad(randf_range(-45, 45))
		var distance = randf_range(40, 60)
		var newX = lastPoint.x + direction.x * distance
		var newZ = lastPoint.z + direction.z * distance
		path.curve.add_point(Vector3(newX, lastPoint.y, newZ))
		direction = Vector3(direction.x, 0, direction.z).rotated(Vector3.UP, rotationAngle)
		lastPoint.x = newX
		lastPoint.z = newZ
