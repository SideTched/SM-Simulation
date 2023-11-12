extends Node
class_name fermion

# c (The Speed of Light), measuered in m/s
const c: int = 299_792_458

# h (Planck Constant), measuered in J*s
const h: float = 6.626_070_15 * pow(10, -34)
const ħ: float = h/2*PI

# Anti, dictates whether the fermion is an anti particle
@export var anti: bool = false

# One Handed, dictates whether the fermion can be both left and right handed
@export var one_handed: bool = false

# Higgs Field Interaction, dictates the mass of the fermion
@export var higgs_field_interaction: float = 0

# Charge, dictates how the fermion interacts with other charged particles
# This varible should be inputed as a number three times larger than the real spin
@export var charge: float = 0

# Color Charge, dictates how the fermion interacts with other color charged particles
@export var color_charge = Color(0, 0, 0)

# Spin Intervals, dictates what spins are possible for the fermion
# This varible should be inputed as a number three times larger than the real spin
@export var spin_intervals: int = 0

# Geration, dictates which particles can be exchanged via the weak force for leptons
@export var generation: int = 1
