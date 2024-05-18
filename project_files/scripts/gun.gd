extends Node2D

@export var Bullet : PackedScene;

@onready var muzzle = $Gun2/Muzzle
@onready var fire_rate_timer = $FireRateTimer

var can_fire = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Shoot"):
		Shoot();

func _physics_process(delta):
	pass;

func Shoot():
	if can_fire:
		var bullet = Bullet.instantiate();
		owner.owner.add_child(bullet);
		bullet.global_transform = muzzle.global_transform;
		can_fire = false;
		fire_rate_timer.start();
	


func _on_fire_rate_timer_timeout():
	can_fire = true;
