# CitySmashinCrittersRevival

Made for the Society of Play's [Revival Jam 2025](https://itch.io/jam/revival-jam-2025).

I choose to revive the first 3d game I worked on - [City Smashin Critters](https://github.com/Wake1st/CitySmashinCritters). This time around, I'm using Godot instead of Unity.

## Requirements

- [ ] character controller: locked axis translation in xz-plane, camera rotate in 90 degree pivots (4 angles)
  - [ ] arrow keys for movement
  - [ ] a/s keys for turning
  - [ ] z/x keys for attacking
- [ ] attack/health: critter can strike buildings, buildings crumble when health passes zero
  - [ ] hit boxes appear when hitting
  - [ ] upon contact, health is deducted from collision body
- [ ] power up: special attack
  - [ ] each character has a different power up, thus, different requirements for said power up
- [ ] characters: 3 varieties
  - [ ] Big Slamma: heavy attacks, slow movement, Slamma-Stomp special
  - [ ] Crazy Teri: random attacks, med movement, Teri-Twister special
  - [ ] Slicer Sue: quick attacks, fast movement, Concussive Shock Wall special
- [ ] score system: score = damage / time
- [ ] score UI: card showing viewport of posing critter, overlayed with metrics. buttons to replay, menu, or continue
  - [ ] viewport without UI: can/should it be framed?
  - [ ] slide in UI
  - [ ] camera in different scene with the character, must slide and snap into stable (use animation player)
  - [ ] score values should overlay, each counting upward, playing rising sfx (a little jiggle when done?)
  - [ ] allow skipping counting if any button pressed
  - [ ] after counting finished, display buttons for: MENU, RESTART, NEXT
- [ ] HUD UI: avatar, power level, time, damage
  - [ ] avatar in top left
  - [ ] power bar starting in top left, stretching across the middle, doesn't hit the right
  - [ ] time in top right
  - [ ] damage under the time
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
    - [ ] idle: sets a bass beat
    - [ ] strike: adds drums
    - [ ] special: adds a guitar
- [ ] sfx: hit sounds, power up
- [ ] character animations: 3 spritesheets of 72 frames (12x6 sized spritesheets)
  - [ ] 3 characters
  - [ ] 3 directions: front, back, left/right (those can be mirrored)
  - [ ] 4 sets (idle, walking, striking, special)
  - [ ] 6 frames per cycle?
- [ ] buildings: need 3d mesh that jiggles, hit box, health
  - [ ] shader that adjusts vertcies per height level
  - [ ] area 3d for collision
  - [ ] adjust health function
- [ ] writing: authoritarian government, monster to fight the tyrany
- [ ] voice acting: sports commentors (data and feels)
  - [ ] data: give statistics, more factual and clear innuciated
  - [ ] feels: loosy goosy, "psychological" factor
- [ ] levels: 9? (small flat, small hills, cliff, med flat, med river, med tiers, large trench, large port, large walls)
  - [ ] 1:
  - [ ] 2:
  - [ ] 3:
  - [ ] 4:
  - [ ] 5:
  - [ ] 6:
  - [ ] 7:
  - [ ] 8:
  - [ ] 9:
- [ ] 3D assets: rectangle buildings, cars, trees, special buildings
  - [ ] low poly, simple
  - [ ] should be quirky shaped already
- [ ] terrain: simple mesh
  - [ ] nothing complicated
  - [ ] the texture should be hand drawn
