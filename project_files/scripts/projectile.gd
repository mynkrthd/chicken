extends Area2D

@export var speed = 1200;
@export var damage = 3.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

func _physics_process(delta):
	position += transform.x * speed * delta;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bullet_lifetime_timeout():
	queue_free();


func _on_body_entered(body):
	#TODO: Emit signal when hit?
	var transf = global_transform;
	if body.name == "baseTile" || body.name == "midTile" || body.name == "detailTile":
		pass;
	elif body.collision_layer == 2 || body.collision_layer == 3 || body.collision_layer == 4:
		body.take_damage(damage);
	#TODO: Implement Bullet implact
	#var bullet_impact = load("res://presets/bullet_impact.tscn").instantiate();
	#owner.add_child(bullet_impact);
	#bullet_impact.global_transform = transf;
	queue_free();
