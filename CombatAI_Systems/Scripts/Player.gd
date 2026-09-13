class_name Player
extends CharacterBody3D
@onready var camera_yaw = $CameraYaw
@onready var camera_pitch = $CameraYaw/CameraPitch
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var idle_state: IdleState = $StateMachine/IdleState
@onready var animation_player: AnimationPlayer = $Character/AnimationPlayer

var mouse_sensitivity := 0.0015

var movementSpeed = 5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	state_machine.initialize(idle_state, self)

func _process(delta: float):
	state_machine.update(delta)

func _physics_process(delta: float):
	state_machine.physics_update(delta)
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	move_character(input)

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

	velocity = movement * movementSpeed
	move_and_slide()
