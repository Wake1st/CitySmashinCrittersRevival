class_name SpectatorState


const PAT_FILLER_1 = preload("uid://kp0mnt66mm3f")
const PAT_FILLER_2 = preload("uid://wxasvbs2ocv3")
const PAT_FILLER_3 = preload("uid://decovjags16dx")
const PAT_FILLER_4 = preload("uid://ua74bknqdiqb")
const PAT_FILLER_5 = preload("uid://ba18jn3e17wmc")
const PAT_FILLER_6 = preload("uid://bnddr7r1otoie")
const WALLY_FILLER_1 = preload("uid://bk61s267e8u5k")
const WALLY_FILLER_2 = preload("uid://4h71kf6ikvlb")
const WALLY_FILLER_3 = preload("uid://ctmsooof8llwo")
const WALLY_FILLER_4 = preload("uid://gann6yc4mjgf")
const WALLY_FILLER_5 = preload("uid://dxdrjn15mok7y")
const WALLY_FILLER_6 = preload("uid://ck0206iycu6f2")

const PAT_INTRO = preload("uid://ue57jvq888ii")
const PAT_PLAINSVIEW = preload("uid://bcddqbu6ymw12")
const PAT_BIG_SLAMMA_INTRO = preload("uid://chwiiircejxxs")
const WALLY_INTRO = preload("uid://vp1a4w6xyvv4")
const WALLY_PLAINSVIEW = preload("uid://clq63klvkbul4")
const WALLY_BIG_SLAMMA_INTRO = preload("uid://caauagpcau2vw")

const PAT_ATTACK_1 = preload("uid://damp0qwa7tevl")
const PAT_ATTACK_2 = preload("uid://dsr54p1g2pfrn")
const PAT_ATTACK_3 = preload("uid://bkipebclc3y50")
const PAT_ATTACK_4 = preload("uid://dnm1voh2x7v3t")
const PAT_ATTACK_5 = preload("uid://fe1iqm1c18cw")
const PAT_ATTACK_6 = preload("uid://c05ml6hotayp0")
const PAT_ATTACK_7 = preload("uid://b2y1w6iju2nua")
const PAT_ATTACK_8 = preload("uid://will0ktaigye")
const PAT_ATTACK_9 = preload("uid://bedfoh26j53rk")
const PAT_ATTACK_10 = preload("uid://d3g8r0hs8f0ud")
const PAT_ATTACK_11 = preload("uid://ca6yq1r0fo7j5")
const PAT_ATTACK_12 = preload("uid://c02bmqfij8f6v")
const WALLY_ATTACK_1 = preload("uid://k3ravkrmow2j")
const WALLY_ATTACK_2 = preload("uid://b7ba4dj6efmla")
const WALLY_ATTACK_3 = preload("uid://duep3uvgxm704")
const WALLY_ATTACK_4 = preload("uid://db5b2s6g268u")
const WALLY_ATTACK_5 = preload("uid://d3005ekav23c3")
const WALLY_ATTACK_7 = preload("uid://rdo4t42a67oj")
const WALLY_ATTACK_8 = preload("uid://diycbs1yvvvvf")
const WALLY_ATTACK_9 = preload("uid://lv1m0esnjksx")
const WALLY_ATTACK_10 = preload("uid://dobh2guygtcoe")
const WALLY_ATTACK_11 = preload("uid://bmjd3ivwlo5pf")
const WALLY_ATTACK_12 = preload("uid://cqu22vd5620ng")

const PAT_LEVEL_TIME_FULL_1 = preload("uid://f6q6r5vmjckd")
const PAT_LEVEL_TIME_FULL_2 = preload("uid://6rbppd43fn0y")
const PAT_LEVEL_TIME_HALF_1 = preload("uid://bjhw5iqb73p4n")
const PAT_LEVEL_TIME_HALF_2 = preload("uid://dh0qerhuc27sp")
const PAT_LEVEL_TIME_ALMOST_1 = preload("uid://hjvxcckk22pq")
const PAT_LEVEL_TIME_ALMOST_2 = preload("uid://d1fqbt6jor4lf")
const WALLY_LEVEL_TIME_FULL_1 = preload("uid://ov85m76x2j4r")
const WALLY_LEVEL_TIME_FULL_2 = preload("uid://br736yprrbt4d")
const WALLY_LEVEL_TIME_HALF_1 = preload("uid://dvf2jqnpehqe0")
const WALLY_LEVEL_TIME_HALF_2 = preload("uid://dx14wyq03nsig")
const WALLY_LEVEL_TIME_ALMOST_1 = preload("uid://b6iiwbkh61sry")
const WALLY_LEVEL_TIME_ALMOST_2 = preload("uid://ci1b0uqqlh5lv")

const PAT_SPECIAL_HALF_CHARGE = preload("uid://bsbd06qgpy5gs")
const PAT_SPECIAL_READY = preload("uid://bnvkc6nxxf5x7")
const PAT_SPECIAL_HALF_EMPTY = preload("uid://bbn7uy6e0i0cu")
const PAT_SPECIAL_FAILURE = preload("uid://ds3vhpn20dw7w")
const WALLY_SPECIAL_HALF_CHARGE = preload("uid://jlvjfgj411jq")
const WALLY_SPECIAL_READY = preload("uid://kk3fm6cqcpbh")
const WALLY_SPECIAL_HALF_EMPTY = preload("uid://phul3lqbcceu")
const WALLY_SPECIAL_FAILURE = preload("uid://cmmwukbr7ooux")
const SLAMMA_STOMP = preload("uid://sm677tgda8kg")

const PAT_WRAP_UP_FAIL_1 = preload("uid://d147b26fmbetx")
const PAT_WRAP_UP_FAIL_2 = preload("uid://bmsuoxhthybf3")
const PAT_WRAP_UP_PASS_1 = preload("uid://janns6mrgufq")
const PAT_WRAP_UP_PASS_2 = preload("uid://41w4pvd3yg0c")
const WALLY_WRAP_UP_PASS_1 = preload("uid://b2rqn15ihcul7")
const WALLY_WRAP_UP_PASS_2 = preload("uid://c0r2nygy7lkd6")
const WALLY_WRAP_UP_FAIL_1 = preload("uid://bfbwkxamtngsu")
const WALLY_WRAP_UP_FAIL_2 = preload("uid://cyfjcnuwq1s8b")

const WALLY_WRAP_UP_1 = preload("uid://bo0727pnjpeui")

enum Flags {
	FILLER = 0,
	INTRO = 1 << 0,
	LOCATION = 1 << 1,
	CHARACTER = 1 << 2,
	ATTACK = 1 << 3,
	LEVEL_TIME_FULL = 1 << 4,
	LEVEL_TIME_HALF = 1 << 5,
	LEVEL_TIME_CLOSE = 1 << 6,
	SPECIAL_HALF_CHARGED = 1 << 7,
	SPECIAL_READY = 1 << 8,
	SPECIAL_HALF_EMPTY = 1 << 9,
	SPECIAL_ACTIVATED = 1 << 10,
	SPECIAL_FAILED = 1 << 11,
	WRAP_UP_PASS = 1 << 12,
	WRAP_UP_FAIL = 1 << 13,
	ANNOUNCER_PAT = 1 << 14,
	ANNOUNCER_WALLY = 1 << 15
}

enum Announcers {
	PAT,
	WALLY
}

static var current_flags : int = 0
static var current_announcer: Announcers = Announcers.PAT


func get_next_sound() -> AudioStreamWAV:
	# first, swap announcers
	match current_announcer:
		Announcers.PAT:
			current_announcer = Announcers.WALLY
		Announcers.WALLY:
			current_announcer = Announcers.PAT
	
	# get the audio by highest preferance
	if (current_flags & Flags.INTRO) && (current_announcer == Announcers.WALLY):
		return WALLY_INTRO
	if (current_flags & Flags.INTRO) && (current_announcer == Announcers.PAT):
		return PAT_INTRO
	if (current_flags & Flags.LOCATION) && (current_announcer == Announcers.WALLY):
		return WALLY_PLAINSVIEW
	if (current_flags & Flags.LOCATION) && (current_announcer == Announcers.PAT):
		return PAT_PLAINSVIEW
	if (current_flags & Flags.CHARACTER) && (current_announcer == Announcers.WALLY):
		return WALLY_BIG_SLAMMA_INTRO
	if (current_flags & Flags.CHARACTER) && (current_announcer == Announcers.PAT):
		return PAT_BIG_SLAMMA_INTRO
	
	if (current_flags & Flags.WRAP_UP_PASS) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_WRAP_UP_PASS_1, 
			WALLY_WRAP_UP_PASS_2
		][randi_range(0, 1)]
	if (current_flags & Flags.WRAP_UP_PASS) && (current_announcer == Announcers.PAT):
		return [
			PAT_WRAP_UP_PASS_1, 
			PAT_WRAP_UP_PASS_2
		][randi_range(0, 1)]
	if (current_flags & Flags.WRAP_UP_FAIL) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_WRAP_UP_FAIL_1, 
			WALLY_WRAP_UP_FAIL_2
		][randi_range(0, 1)]
	if (current_flags & Flags.WRAP_UP_FAIL) && (current_announcer == Announcers.PAT):
		return [
			PAT_WRAP_UP_FAIL_1, 
			PAT_WRAP_UP_FAIL_2
		][randi_range(0, 1)]
	
	if (current_flags & Flags.SPECIAL_ACTIVATED):
		return SLAMMA_STOMP
	if (current_flags & Flags.SPECIAL_FAILED) && (current_announcer == Announcers.WALLY):
		return WALLY_SPECIAL_FAILURE
	if (current_flags & Flags.SPECIAL_FAILED) && (current_announcer == Announcers.PAT):
		return PAT_SPECIAL_FAILURE
	if (current_flags & Flags.SPECIAL_HALF_EMPTY) && (current_announcer == Announcers.WALLY):
		return WALLY_SPECIAL_HALF_EMPTY
	if (current_flags & Flags.SPECIAL_HALF_EMPTY) && (current_announcer == Announcers.PAT):
		return PAT_SPECIAL_HALF_EMPTY
	if (current_flags & Flags.SPECIAL_READY) && (current_announcer == Announcers.WALLY):
		return WALLY_SPECIAL_READY
	if (current_flags & Flags.SPECIAL_READY) && (current_announcer == Announcers.PAT):
		return PAT_SPECIAL_READY
	if (current_flags & Flags.SPECIAL_HALF_CHARGED) && (current_announcer == Announcers.WALLY):
		return WALLY_SPECIAL_HALF_CHARGE
	if (current_flags & Flags.SPECIAL_HALF_CHARGED) && (current_announcer == Announcers.PAT):
		return PAT_SPECIAL_HALF_CHARGE
	
	if (current_flags & Flags.LEVEL_TIME_CLOSE) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_LEVEL_TIME_ALMOST_1, 
			WALLY_LEVEL_TIME_ALMOST_2
		][randi_range(0,1)]
	if (current_flags & Flags.LEVEL_TIME_CLOSE) && (current_announcer == Announcers.PAT):
		return [
			PAT_LEVEL_TIME_ALMOST_1, 
			PAT_LEVEL_TIME_ALMOST_2
		][randi_range(0,1)]
	if (current_flags & Flags.LEVEL_TIME_HALF) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_LEVEL_TIME_HALF_1, 
			WALLY_LEVEL_TIME_HALF_2
		][randi_range(0,1)]
	if (current_flags & Flags.LEVEL_TIME_HALF) && (current_announcer == Announcers.PAT):
		return [
			PAT_LEVEL_TIME_HALF_1, 
			PAT_LEVEL_TIME_HALF_2
		][randi_range(0,1)]
	if (current_flags & Flags.LEVEL_TIME_FULL) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_LEVEL_TIME_FULL_1, 
			WALLY_LEVEL_TIME_FULL_2
		][randi_range(0,1)]
	if (current_flags & Flags.LEVEL_TIME_FULL) && (current_announcer == Announcers.PAT):
		return [
			PAT_LEVEL_TIME_FULL_1, 
			PAT_LEVEL_TIME_FULL_2
		][randi_range(0,1)]
	
	if (current_flags & Flags.ATTACK) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_ATTACK_1,
			WALLY_ATTACK_2,
			WALLY_ATTACK_3,
			WALLY_ATTACK_4,
			WALLY_ATTACK_5,
			WALLY_ATTACK_7,
			WALLY_ATTACK_8,
			WALLY_ATTACK_9,
			WALLY_ATTACK_10,
			WALLY_ATTACK_11,
			WALLY_ATTACK_12
		][randi_range(0,11)]
	if (current_flags & Flags.ATTACK) && (current_announcer == Announcers.PAT):
		return [
			PAT_ATTACK_1,
			PAT_ATTACK_2,
			PAT_ATTACK_3,
			PAT_ATTACK_4,
			PAT_ATTACK_5,
			PAT_ATTACK_7,
			PAT_ATTACK_8,
			PAT_ATTACK_9,
			PAT_ATTACK_10,
			PAT_ATTACK_11,
			PAT_ATTACK_12
		][randi_range(0,11)]
	
	if (current_flags & Flags.FILLER) && (current_announcer == Announcers.WALLY):
		return [
			WALLY_FILLER_1,
			WALLY_FILLER_2,
			WALLY_FILLER_3,
			WALLY_FILLER_4,
			WALLY_FILLER_5,
			WALLY_FILLER_6
		][randi_range(0,5)]
	else: # (current_flags & Flags.FILLER) && (current_announcer == Announcers.PAT):
		return [
			PAT_FILLER_1,
			PAT_FILLER_2,
			PAT_FILLER_3,
			PAT_FILLER_4,
			PAT_FILLER_5,
			PAT_FILLER_6
		][randi_range(0,5)]
