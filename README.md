# CitySmashinCrittersRevival

Made for the Society of Play's [Revival Jam 2025](https://itch.io/jam/revival-jam-2025).

I choose to revive the first 3d game I worked on - [City Smashin Critters](https://github.com/Wake1st/CitySmashinCritters). This time around, I'm using Godot instead of Unity, and it's been encouraging to see how much better I've gotten at game development.

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
- [Shield Shader with Intersection Highlight](https://godotshaders.com/shader/shield-shader-with-intersection-highlight/)
- [Speed Lines Shader](https://godotshaders.com/shader/speed-lines-shader-for-godot-4/)

## Resources

- [Latte Noon Groove](https://tinyurl.com/256yqa7w)
- [Big Stomp](https://tinyurl.com/28sqywyn)

## Issues

- [ ] returning from special should not activate attack

## Requirements

### Post Jam Feedback

- [x] camera shake
- [x] sprint feature
	- [x] stamina bar (stalls on empty, need a cooldown before refilling)
- [x] flying debris
- [x] action lines (for sprinting | only one type)
- [x] dust clouds
- [ ] explosions
- [ ] more sfx

### Stretch Goals

- [ ] features
	- [ ] throw buildings (cost energy)
	- [ ] sprint tackle (cost energy / or stamina?)
	- [ ] broken building bits / debris
	- [ ] footstep shake?
	- [ ] water (go in, hit boats)
	- [ ] light/heavy attack
	- [ ] eating (for energy)
	- [ ] building physics
	- [ ] small stuff (planes, cars, trees)
- [ ] vfx
	- [ ] action lines
		- [ ] building shake
		- [ ] dash (multiple directions)
		- [ ] special?
	- [ ] dust clouds
		- [ ] fit to building mesh
		- [ ] wind effected
		- [ ] volumetric fog tweaking
- [ ] writing: for the story (just stick with announcers for the jam)
	- [ ] authoritarian government, monster to fight the tyrany
	- [ ] summons [Buddha](https://www.youtube.com/watch?v=FmEntfLk8Qk&list=PLIdROkqAzq9C8_iwRdPp7JhPAnbzah2uk), who purifies the corrupt with beams of pure light
- [ ] levels
	- [ ] 4) Woody Valley:
	- [ ] 5) Sludge Corp:
	- [ ] 6) Copperton:
	- [ ] 7) Plant Hell:
	- [ ] 8) The Garden:
	- [ ] 9) Serpents Tower: small
- [ ] common building generator
	- [ ] editor inputs for file name
	- [ ] grey out the colors more?
	- [ ] configure health and cost with size enums
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
- [ ] menu UI: levels, settings, credits
	- [ ] voice lines on focused
- [ ] characters
	- [ ] Crazy Teri: floppy and spinny, triangular shaped, silly eyes
		- [ ] random attacks: twirl and wobble
		- [ ] med movement: arm windmills while power walking
		- [ ] Teri-Twister special:  random pattern of destruction
	- [ ] Sue Slicer: tall and slender, like an axe handle, mad eyes
		- [ ] quick attacks: chops shapped like an axe
		- [ ] fast movement: cartwheels!
		- [ ] Concussive Wall Shock special: multiple slams pointed at one direction send a flat showckwave destroying everything in a straight line
- [ ] score system: score = damage / time
	- [ ] ranking system
- [ ] mission types
	- [ ] target: destroy a specific target before the timer runs out
