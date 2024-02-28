extends Node
class_name fermion

# c (The Speed of Light), measuered in m/s
const c: int = 299_792_458

# h (Planck Constant), measuered in J*s
const h: float = 6.626_070_15 * pow(10, -34)
const ħ: float = h/2*PI

<<<<<<< Updated upstream
=======
# k coulumbs constant
const k: float = 8.987_5 * pow(10, 9) 

# k, strong force constant
const σstrong = 137_000_000_000

const reductionconst = pow(10, -6)

var time = 0

@onready var area = $Area3D

>>>>>>> Stashed changes
# Anti, dictates whether the fermion is an anti particle
@export var anti: bool = false

# One Handed, dictates whether the fermion can be both left and right handed
@export var one_handed: bool = false

# Higgs Field Interaction, dictates the mass of the fermion
<<<<<<< Updated upstream
@export var higgs_field_interaction: float = 0
=======
@export var rest_mass: float = 0
>>>>>>> Stashed changes

# Charge, dictates how the fermion interacts with other charged particles
# This varible should be inputed as a number three times larger than the real spin
@export var charge: float = 0

# Color Charge, dictates how the fermion interacts with other color charged particles
@export var color_charge = Color(0, 0, 0)

# Spin Intervals, dictates what spins are possible for the fermion
<<<<<<< Updated upstream
# This varible should be inputed as a number three times larger than the real spin
=======
# This varible should be inputed as a number two times larger than the real spin
>>>>>>> Stashed changes
@export var spin_intervals: int = 0

# Geration, dictates which particles can be exchanged via the weak force for leptons
@export var generation: int = 1
<<<<<<< Updated upstream
=======

@export var particle_origin: Vector3 

@export var particle_velocity : Vector3

@export var photon : PackedScene
var mass
var vectorzero = Vector3.ZERO
var particle_sum_force
var particle_acceleration

func _ready() -> void:
	if anti:
		charge = -charge
		color_charge = Color(255,255,255, 2) - color_charge
	$Area3D.anti = anti
	particle_velocity /= reductionconst


func _physics_process(delta: float) -> void:
	particle_sum_force = Vector3.ZERO
	particle_acceleration = Vector3.ZERO
	
	time += delta
	
	if charge != 0:
		calculate_elctromganetic_force()
	
	if color_charge != Color(0, 0, 0):
		calculate_strong_nuclear_force()
	
	mass = rest_mass / (sqrt(1 - (pow(vectorzero.distance_to(particle_velocity), 2)/pow(c, 2))))
	$Area3D.mass = mass
	
	particle_acceleration = particle_sum_force / mass
	
	particle_velocity += particle_acceleration * delta * reductionconst
	
	self.transform.origin += particle_velocity * reductionconst
	
	$Area3D.KE = mass * particle_velocity * particle_velocity / 2
	$Area3D.v = particle_velocity
	$Area3D.pos = self.transform.origin
	print($Area3D.pos, time)
	
func calculate_elctromganetic_force():
	for particle in self.get_parent().get_children():
		
		if particle.is_in_group("fermion"):
			
			if (Vector3(particle.transform.origin) - Vector3(self.transform.origin)).normalized() != Vector3.ZERO:
				if (particle.charge > 0 and self.charge < 0) or (particle.charge < 0 and self.charge > 0):
					particle_sum_force += k * abs(charge * particle.charge / 9) / pow(self.transform.origin.distance_to(particle.transform.origin), 2) * (Vector3(particle.transform.origin) - Vector3(self.transform.origin)).normalized()
				elif (particle.charge < 0 and self.charge < 0) or (particle.charge > 0 and self.charge > 0):
					particle_sum_force += k * abs(charge * particle.charge / 9) / pow(self.transform.origin.distance_to(particle.transform.origin), 2) * -(Vector3(particle.transform.origin) - Vector3(self.transform.origin)).normalized()

func calculate_strong_nuclear_force():
	for particle in self.get_parent().get_children():
		if particle.is_in_group("fermion") and particle.color_charge != Color(0, 0, 0, 1):
			if color_charge + particle.color_charge == Color(255, 255, 255, 2):
				
				
				particle_sum_force += ((σstrong * self.transform.origin.distance_to(particle.transform.origin)) - (1 / self.transform.origin.distance_to(particle.transform.origin))) * (Vector3(particle.transform.origin) - Vector3(self.transform.origin)).normalized()
				
func _on_area_3d_area_entered(area: Area3D) -> void:
	if snapped(area.mass, 0.0001) == snapped(mass, 0.0001) and ((area.anti == true and anti == false) or (area.anti == false and anti == true)):
		if anti == false:
			if particle_velocity + area.v != Vector3.ZERO:
				var death_photon = photon.instantiate()
				self.get_parent().add_child(death_photon)
				death_photon.transform.origin = (self.transform.origin + area.pos)/2
				death_photon.particle_velocity = particle_velocity + area.v
				
		queue_free()
	else:
		if area.mass == 0:
			particle_velocity = area.v.normalized() * vectorzero.distance_to(particle_velocity)
		else:
			particle_velocity = (((mass - area.mass) * particle_velocity) + (2 * area.mass * area.v) / (mass + area.mass))
>>>>>>> Stashed changes
