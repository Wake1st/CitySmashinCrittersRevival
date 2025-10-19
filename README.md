# CitySmashinCrittersRevival

Made for the Society of Play's [Revival Jam 2025](https://itch.io/jam/revival-jam-2025).

I choose to revive the first 3d game I worked on - [City Smashin Critters](https://github.com/Wake1st/CitySmashinCritters). This time around, I'm using Godot instead of Unity.

## Contributions

- fork this repo
- clone the fork with the clone command: `git clone *repo address*`
- fetch remote branches: `git fetch origin`
- checkout the prototype branch: `git checkout prototype`
- create a new branch off of prototype: `git checkout -b *branch name*`
- make changes
- track changes: `git add .`
- create a commit: `git commit -m "commit message"`
- push commit to remote: `git push origin *branch name*`
- when finished, notify dev or create a Pull Request in GitHub

## Model Importing

- add to the "assets/models/"
- double click the model file to open the advanced import settings
- select each animation real and set the `Loop Mode` to "Linear"

## Big Slamma Editing

- these changes should be kept to the "Big Slamma" imported scene and attached script
- make sure any animation name changes are updated in the script

## Special Thanks

- [Universal Transition Shader](https://github.com/cashew-olddew/Universal-Transition-Shader)

## Resources

- [Late Noon Groove](https://tinyurl.com/295qfg5b)
- [Big Stomp](https://tinyurl.com/28sqywyn)

## Issues

- [ ] there seems to be an issue when using the special a second time

## Requirements

- [x] character controller: locked axis translation in xz-plane, camera rotate in 90 degree pivots (4 angles)
	- [x] WASD/arrow keys for movement
	- [x] Q,E keys for turning
	- [x] space key for attacking
- [x] buildings: need 3d mesh that jiggles, hit box, health
	- [x] area 3d for collision
	- [x] adjust health function
	- [x] wobbles
- [x] attack/health: critter can strike buildings, buildings crumble when health passes zero
	- [x] upon contact, health is deducted from destructable
- [x] HUD UI: avatar, power level, time, damage
	- [x] time in top right
	- [x] damage under the time
	- [x] power bar starting in top left, stretching across the middle, doesn't hit the right
- [x] voice acting: sports commentors (facts and feels)
	- [x] facts - Desmond Wallace (Gene Okerlund): give statistics, more factual and clear innuciated
	- [x] feels - Pat Sullivan (John Madden): loosy goosy, "psychological" factor
	- [x] maybe out of scope ~~excitement matches destruction per minute~~
	- [x] scream out the special names
	- [x] lines
		- [x] introductions (they introduce each other)
		- [x] locations (each talks about the level)
		- [x] character intros
		- [x] level time
			- [x] 100%
			- [x] 50%
			- [x] 5%
		- [x] wrap up
			- [x] pass
			- [x] fail
		- [x] special
			- [x] 50% charged
			- [x] ready
			- [x] 50% empty
			- [x] activated (at the same time)
			- [x] failed
		- [x] attack
		- [x] filler
- [x] pause UI
- [x] score UI: card showing viewport of posing critter, overlayed with metrics. buttons to replay, menu, or continue
	- [x] slide in UI
	- [x] score values should overlay, each counting upward, playing rising sfx (a little jiggle when done?)
	- [x] viewport without UI: can/should it be framed?
	- [x] camera in different scene with the character, must slide and snap into stable (use animation player)
	- [x] allow skipping counting if any button pressed
	- [x] after counting finished, display buttons for: MENU, RESTART, NEXT
- [x] terrain: simple mesh, nothing complicated
- [x] score system: score = damage / time
	- [ ] ranking system
- [ ] mission types
	- [x] quota: cause a number of damage before timer runs out
	- [x] timed: destroy as much as possible in the given time
	- [ ] target: destroy a specific target before the timer runs out
- [ ] power up: special attack
	- [x] character charges up special move
	- [ ] special name is displayed in big words while the announcers sound out the name
	- [x] camera showing multiple angles depending on the damange done (3-5), replaying the destruction per shot
	- [x] final shot is far above, high FOV, focused on the path of destruction
	- [x] after final shot, camera zips to characer with correct FOV
	- [ ] vfx and sfx to note the moment
- [ ] characters: 3 varieties
	- [ ] Big Slamma: thicc, sumo fury, circular shaped, serious eyes
		- [ ] heavy attack: punching with wide stance
		- [ ] slow movement: bow legged swagger
		- [ ] Slamma-Stomp special: jumps up and slams down, destroying in a wave
	- [ ] Crazy Teri: floppy and spinny, triangular shaped, silly eyes
		- [ ] random attacks: twirl and wobble
		- [ ] med movement: arm windmills while power walking
		- [ ] Teri-Twister special:  random pattern of destruction
	- [ ] Sue Slicer: tall and slender, like an axe handle, mad eyes
		- [ ] quick attacks: chops shapped like an axe
		- [ ] fast movement: cartwheels!
		- [ ] Concussive Wall Shock special: multiple slams pointed at one direction send a flat showckwave destroying everything in a straight line
- [ ] menu UI: levels, settings, credits
	- [ ] transparent overlay
	- [ ] voice lines on focused
- [ ] start screen: critter AI attacking buildings in background
	- [ ] random level, random critter, random attacks, no specials
- [ ] music: metal (Judas Priest, KGLW)
	- [ ] menu music: layers
		- [ ] main: sets a thump beat
		- [ ] levels: adds a guitar
		- [ ] settings: adds chimes/piano
		- [ ] credits: adds singing
	- [ ] levels: layers
		- [ ] idle: sets a simple beat
		- [ ] movement: adds another layer
		- [ ] striking: more layers
		- [ ] special-charging: the higher the meter, the more complex the soundtrack
		- [ ] special-charged: when charged, starts building a bridge
		- [ ] special-execution: big finaly!
	- [ ] characters: each their own theme
		- [ ] Big Slamma: grunge metal, throat singing
		- [ ] Crazy Teri: psychadelic prog rock, harmony vocals
		- [ ] Sue Slicer: jungle dnb, gregorian vocals
- [ ] sfx: hit sounds, power up
- [ ] writing: for the story (just stick with announcers for the jam)
	- [ ] authoritarian government, monster to fight the tyrany
	- [ ] summons [Buddha](https://www.youtube.com/watch?v=FmEntfLk8Qk&list=PLIdROkqAzq9C8_iwRdPp7JhPAnbzah2uk), who purifies the corrupt with beams of pure light
- [ ] dynamic dialog system
	- [ ] use bitflags
	- [ ] play highest priority
	- [ ] build state while audio plays (wipe clean for each cycle)
	- [ ] swap announcers
- [ ] levels: 9
	- [ ] 1) Plainsview:
	- [ ] 2) Hill Top Town (Frog Town?):
	- [ ] 3) Sea Cliff City:
	- [ ] 4) Woody Valley:
	- [ ] 5) Sludge Corp:
	- [ ] 6) Copperton:
	- [ ] 7) Plant Hell:
	- [ ] 8) The Garden:
	- [ ] 9) Serpents Tower: small
- [ ] 3D assets: rectangle buildings, cars, trees, special buildings
	- [ ] low poly, simple
	- [ ] should be quirky shaped already
- [ ] common building generator 
	- [ ] editor inputs for file name
	- [ ] grey out the colors more?
	- [ ] configure health and cost with size enums
- [ ] add boundries to each level
