extends RigidBody3D

var sphere_offset = Vector3.DOWN
var acceleration = 42.0
var steering = 19.0
var turn_speed = 4.0
var turn_stop_limit = 0.75
var body_tilt = 35

var speed_input = 0
var turn_input = 0

# Cache frequently accessed nodes
@onready var car_mesh = $CarMesh
@onready var body_mesh = $CarMesh/suv2
@onready var ground_ray = $CarMesh/RayCast3D
@onready var audio_stream_player = $AudioStreamPlayer3D
var particles: GPUParticles3D = null

func _ready():
	particles = $CarMesh/GPUParticles3D

func _physics_process(_delta):
	car_mesh.position = position + sphere_offset
	if ground_ray.is_colliding():
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)

func _process(delta):
	if not ground_ray.is_colliding() or particles == null:
		return

	speed_input = Input.get_axis("brake", "accelerate") * acceleration
	turn_input = Input.get_axis("steer_right", "steer_left") * deg_to_rad(steering)
	var linear_velocity_length_squared = linear_velocity.length_squared()
	var d = linear_velocity.normalized().dot(-car_mesh.transform.basis.z)
	particles.emitting = linear_velocity_length_squared > 16.0 and d < 0.95 and Global.particles

	if linear_velocity_length_squared > turn_stop_limit * turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		var t = -turn_input * sqrt(linear_velocity_length_squared) / body_tilt
		body_mesh.rotation.z = lerp(body_mesh.rotation.z, t, 5.0 * delta)

	if ground_ray.is_colliding():
		var n = ground_ray.get_collision_normal()
		var xform = align_with_y(car_mesh.global_transform, n)
		car_mesh.global_transform = car_mesh.global_transform.interpolate_with(xform, 10.0 * delta)

	# Play audio based on speed
	var speed_ratio = sqrt(linear_velocity_length_squared) / acceleration
	audio_stream_player.pitch_scale = speed_ratio
	if linear_velocity_length_squared > 0:
		if !audio_stream_player.is_playing():
			audio_stream_player.play()
	else:
		audio_stream_player.stop()

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	return xform.orthonormalized()
