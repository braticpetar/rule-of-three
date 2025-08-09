# Rule of Three

2D pixelart Metroidvania about Dazed Blood Demon's quest to go home and take a well deserved bloodbath. 


## About the Game

The rule of three is a writing principle which suggests that a trio of entities such as events or characters is more humorous, satisfying, or effective than other numbers. Having three entities combines both brevity and rhythm with having the smallest amount of information to create a pattern.

We explore this idea in a Metrodvania type game where everything comes in triads.

- Three Main mechanics:
	- Walk
	- Attack
	- Dissolve/Condense (teleport)

- Three Levels:
	- Mundane Night City
	- Desert of Lost Souls
	- Home Sweet Home

- Three Enemies:
	- Grim the Crow's Beak
	- Soulless Ghostly Wanderer
	- ?? 

- Three Enemy Spawners per Level

- Three Headed Boss

- Three Songs in a Soundtrack


## Design Patterns

- **State Machine:** Each entity in the game is a state machine, which is encapsulated in its own script. We define what happens in each state per entity and simply switch between them as needed from the entity controller script.

- **Singleton:** A global Player singleton is used to track persistent metrics and share data between different scenes

- **Observer:** This pattern is achieved through Godot's signals. All the events that do not require constant checking each frame, such as switching between enemy states, or hitbox/hurtbox mechanisms, are only handled upon receiving a signal. 

- **Factory Pattern:** Represented as a spawner. Spawner simply keeps instantiating enemies and adds them as children of the current scene tree until it's destroyed.


## How Certain Features are Implemented / Algorithms

### Enemy States: 

When idle, each enemy is very slowly walking towards the player's global position received from PlayerSingleton. Each enemy has a defined "chasing area". Once player enters it, enemies are trigged to enter chasing state and start moving faster towards the player with a different animation. Each enemy also has "attacking area". Once player enters that area, enemies switch to attacking state, and start dealing certaing amount of damage every second. Once they are killed, it plays death animation. Once that animation is finished, it triggers a function that safely removes enemy node from the scene.

### Collisions: 

There are separate layers and masks for every type of collision area, so they don't interfere with one another. 

Layer represents a "realm" where that area exists, while mask represents the "realm" it is looking for, want to collide with. So we have fully structured system of preventing unwanted collisions from happening. 

Additionally, player and enemy hitboxes are activated only upon entering attacking state, and are exited upon exiting the state. 


### Parallax Background:

We use layered backgrounds for parallax effect. Upon reaching a defined point, layer is duplicated across x axis so it scrolls indefinetely. And each layer has a different scaling number so it moves at a different speed. Also, there is a separate "smog" layer, which has a level of transparencry and it is moving faster than everything else to achieve the effect of being closer to the camera. 



### Player States:
All input detection is separated into controller logic. Upon detecting input, it switches to different states that are playing different animations. 


## Credits

- Developed by: Petar Bratic for TwoDesperados 2025 Game Jam
- Tools used: Godot Game Engine (GDScript), Aseprite
- All assets used are free assets found on itch.io


## Feedback

If you have found any bugs, have any suggestions or simply want to share your thoughts, feel free to leave a comment, create an issue on GitHub or reach out to me on Discord :)



