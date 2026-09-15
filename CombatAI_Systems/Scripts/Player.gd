class_name Player
extends CharacterBody3D
@onready var camera_yaw = $"../CameraYaw"
@onready var camera_pitch = $"../CameraYaw/CameraPitch"
@onready var camera_target = $"CameraTarget"
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var idle_state: IdleState = $StateMachine/IdleState
@onready var move_state: SwordShieldMovingState = $StateMachine/SwordShieldMovingState
@onready var animation_player: AnimationPlayer = $Character/AnimationPlayer
@onready var animation_tree: AnimationTree = $Character/AnimationTree

var mouse_sensitivity := 0.0015
var movementSpeed = 5

var blend_position := Vector2.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	state_machine.initialize(idle_state, self)

func _process(delta: float):
	camera_yaw.global_position = camera_target.global_position
	state_machine.update(delta)

func _physics_process(delta: float):
	state_machine.physics_update(delta)
	

func _input(event):
	if event is InputEventMouseMotion:
		camera_yaw.rotation.y -= event.relative.x * mouse_sensitivity
		camera_pitch.rotation.x -= event.relative.y * mouse_sensitivity

	camera_pitch.rotation.x = clamp(
		camera_pitch.rotation.x,
		deg_to_rad(-60),
		deg_to_rad(60)
	)

	

func move_character(input: Vector2):
	var movement = Vector3(input.x, 0, input.y)
	

	movement = camera_yaw.global_basis * movement
	movement.y = 0
	movement = movement.normalized()

	if movement != Vector3.ZERO:
		var target_angle = atan2(movement.x, movement.z)
		$Character.rotation.y = lerp_angle(
			$Character.rotation.y,
			target_angle,
			2 * get_physics_process_delta_time()
		)

	velocity = movement * movementSpeed
	move_and_slide()
