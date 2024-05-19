extends Node2D

@export var Bullet : PackedScene;

@onready var gun = $Gun
@onready var muzzle = $Gun/Muzzle
@onready var fire_rate_timer = $FireRateTimer

var can_fire = true;
var gun_original_position = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_original_position = gun.position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Shoot"):
		Shoot();


func Shoot():
	if can_fire:
		#Spawning bullet as the child of the scene root
		var bullet = Bullet.instantiate();
		owner.owner.add_child(bullet);
		bullet.global_transform = muzzle.global_transform;
		#Spawning only according to the gun fire-rate set in the FireRateTimer>wait_time
		can_fire = false;
		fire_rate_timer.start();
		#Recoil Animation
		var tween = create_tween();
		tween.tween_property(gun, "position", Vector2(gun_original_position.x - 5.0, gun_original_position.y), fire_rate_timer.wait_time / 2.0);
		tween.tween_property(gun, "position", gun_original_position, fire_rate_timer.wait_time / 2.0);
	


func _on_fire_rate_timer_timeout():
	can_fire = true;
