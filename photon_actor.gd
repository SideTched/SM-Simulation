extends Node
class_name photon

# c (The Speed of Light), measuered in m/s
const c: int = 299_792_458

# h (Planck Constant), measuered in J*s
const h: float = 6.626_070_15 * pow(10, -34)
const ħ: float = h/2*PI

# k coulumbs constant
const k: float = 8.987_5 * pow(10, 9) 

# k, strong force constant
const σstrong = 137

const reductionconst = pow(10, -6)


@onready var area = $Area3D

# Anti, dictates whether the fermion is an anti particle
@export var anti: bool = false

# One Handed, dictates whether the fermion can be both left and right handed
@export var one_handed: bool = false

# Higgs Field Interaction, dictates the mass of the fermion
@export var mass: float = 0

# Charge, dictates how the fermion interacts with other charged particles
# This varible should be inputed as a number three times larger than the real spin
@export var charge: float = 0

# Color Charge, dictates how the fermion interacts with other color charged particles
@export var color_charge = Color(0, 0, 0)

# Spin Intervals, dictates what spins are possible for the fermion
# This varible should be inputed as a number two times larger than the real spin
@export var spin_intervals: int = 0

# Geration, dictates which particles can be exchanged via the weak force for leptons
@export var generation: int = 1

@export var particle_origin: Vector3 

@export var particle_velocity : Vector3

@export var f = 1

var particle_sum_force

var vectorzero = Vector3.ZERO

var time = 0

func _ready() -> void:
	#print(self.transform.origin)
	#self.transform.origin = particle_origin
	particle_velocity /= reductionconst
	if anti:
		charge = -charge
	$Area3D.anti = anti
	$Area3D.mass = 0

func _physics_process(delta: float) -> void:
	
	time += delta

	particle_velocity = particle_velocity.normalized() * c * reductionconst * delta
	self.transform.origin += particle_velocity
	$Area3D.v = particle_velocity
	$Area3D.pos = self.transform.origin
	print($Area3D.pos, time)

func _on_area_3d_area_entered(area: Area3D) -> void:
	particle_velocity = area.v.normalized() * vectorzero.distance_to(particle_velocity)
