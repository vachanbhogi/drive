extends Path3D

var points = PackedVector3Array()
var timer = Timer.new()
var direction = Vector3.FORWARD

func _ready():
	add_child(timer)
	timer.wait_time = 1.5
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()

func _on_Timer_timeout():
	if curve.get_point_count() > 7:
		curve.remove_point(0) 

	if curve.get_point_count() > 0:
		var last_point = curve.get_point_position(curve.get_point_count() - 1)
		var rotation_angle = deg_to_rad(randf_range(-45, 45))
		var distance = randf_range(40, 60)
		var new_point = Vector3(last_point.x + direction.x * distance, last_point.y, last_point.z + direction.z * distance)
		curve.add_point(new_point)
		direction = Vector3(direction.x, 0, direction.z).rotated(Vector3.UP, rotation_angle)
