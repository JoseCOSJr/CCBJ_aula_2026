extends CharacterBody3D


const SPEED = 5.0
var  JUMP_VELOCITY = 7

@export var alturaPulo = 3
@export var model3D: Node3D
@export var animation: AnimationPlayer
@export var hitbox: Hitbox
@export var hurtbox: Hurtbox
var attAnimationMove: bool = true
var canMove: bool = true

var rotateSpd: float = 12

var canCancelJump: bool = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var audioEmitter: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var sfxAtk1Go: AudioStream
var canAtk: bool = true

func _ready() -> void:
	CalcAltura()

func CalcAltura()->void:
	var tempoDeQueda = alturaPulo*2 / gravity
	tempoDeQueda = sqrt(tempoDeQueda)
	JUMP_VELOCITY = tempoDeQueda*gravity
	


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		if attAnimationMove:
				SetAnimation("FALLING", 1, 0.5)
		
	
	if !is_on_floor() and velocity.y > 0 && Input.is_action_just_released("pulo"):
		CancelJump()
	
	# Handle jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		StartJump()
	
	if Input.is_action_just_pressed("ataque"):
		Atack_1()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	var cameraNow: Camera3D = get_viewport().get_camera_3d()
	var rotationX := (cameraNow.global_rotation.y+deg_to_rad(180))*Vector3.UP
	var quaternion: Quaternion = Quaternion.from_euler(rotationX)
	direction = direction*quaternion
	#print(rad_to_deg(quaternion.get_euler().y))
	
	AttRotate(direction, delta)
	
	if direction && canMove:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor() && attAnimationMove:
			SetAnimation("AZOBE_RUN", 5)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if is_on_floor() && attAnimationMove:
			SetAnimation("IDLE")
	
	
	move_and_slide()

func AttRotate(directionTurn: Vector3, delta: float)->void:
	if directionTurn.length_squared() == 0:
		return
	
	var novoAngY: float = Vector3.BACK.signed_angle_to(directionTurn, Vector3.UP)
	model3D.global_rotation.y = lerp_angle(model3D.global_rotation.y, novoAngY, rotateSpd*delta)


func StartJump()->void:
	velocity.y = JUMP_VELOCITY
	canCancelJump = true
	#som
	#animação

func CancelJump()->void:
	if !canCancelJump:
		return
	
	velocity.y *= 0.5
	canCancelJump = false

func Atack_1()->void:
	if !canAtk:
		return
	
	var speedAnima: float = 5
	SetAnimation("ATTACK_01", speedAnima)
	attAnimationMove = false
	canMove = false
	canAtk = false
	
	audioEmitter.stream = sfxAtk1Go
	audioEmitter.play()
	
	await get_tree().create_timer(1/speedAnima).timeout
	
	hitbox.Active()
	
	await get_tree().create_timer(0.5).timeout
	
	hitbox.Disactive()
	ResetAnimation()
	canMove = true
	canAtk = true

func SetAnimation(nameAnima: String, speedAnima: float = 1, valueTrasion:float = 0.2)->void:
	if !animation:
		return
	
	animation.play(nameAnima, valueTrasion, speedAnima)

func ResetAnimation()->void:
	SetAnimation("IDLE")
	attAnimationMove = true

func save():
	var save_dict = {
		"filename" : scene_file_path,
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"pos_z" : position.z,
		"current_health" : GameManager.gameManagerInScene.hpPlayer,
	}
	return save_dict

func load_data(node_data)->void:
	position.x = node_data["pos_x"]
	position.y = node_data["pos_y"]
	position.z = node_data["pos_z"]
	GameManager.gameManagerInScene.hpPlayer = node_data["current_health"]
	

func DamageAnimation()->void:
	SetAnimation("DAMAGE",)
