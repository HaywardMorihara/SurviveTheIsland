# Survive the Island

Made By:
* [Murphy's Dad](https://murphysdad.itch.io/)
* [ScrapyNinja](https://scrapyninja.itch.io/)
* [00Her0](https://00her0.itch.io/)
* [imortalicecream](https://itch.io/profile/immortalicecream)

For the [GDFG June 2022 Game Jam](https://itch.io/jam/gdfgs-monthly-game-jam-17).

Built w/ Godot Version: v3.4.4

## Git
**IMPORTANT**
If you're working on Windows, run this command once you've cloned the repo:
```sh
git config --global core.autocrlf input
```

We'll use the standard [branch/pull request/merge Github workflow](https://docs.github.com/en/get-started/quickstart/github-flow) for collaborating on this project.

Aim to keep branches as short-lived as possible (so that they don't diverge too far from the `main` branch, the final, shared branch).

https://desktop.github.com/ provides a Git UI if you're more comfortable working with a UI (rather than the terminal).

### Git Commands
* To try someone else's branch that they've pushed to the Github repository:
    ```sh
    git switch <THEIR_BRANCH>
    ```
    For more info, see [here](https://stackoverflow.com/questions/9537392/git-fetch-remote-branch).
* To rebase your branch to the latest changes in `main`:
    ```sh
    # These two commands update your local main to be the same as Github's main branch
    git checkout main
    git pull origin main

    # Now go back to your branch, and rebase onto the latest version of main
    git checkout <YOUR_BRANCH>
    git rebase main
    ```
    For more info, see [here](https://stackoverflow.com/questions/3876977/update-git-branches-from-master).

## Code

**Blocks**

We're thinking all starting "blocks" are tiles in the Tilemap.

Then, when placing "Blocks", they're RigidBody, StaticBody, or KinematicBody (for different types of blocks w/ different properties).

IMPORTANT: Make sure Blocks are part of the Collision Layer and Collision Mask '5'. I'm not sure exactly why the demo did this (why does the game need it? Is it just best practice?). We haven't bothered to change it (yet, anyway).


### Building Off of Godot's Platformer Demo
The code was built off of [Godot's official Platformer Demo](https://godotengine.org/asset-library/asset/120). We've taken out parts that we don't need (enemies, bullets) and kept the core of what we need (jumping, background, controls, etc.), along with a few features that we don't need now but _might_ want (coins, platforms, splitscreen).

Things to note:
* I left the `Shoot` code in and renamed as `BlockPlacement` - thinking we can reuse parts of this code for letting the player place blocks.
* I left the assets (art, music, sfx) in as placeholders until we have our own (but planning on replacing it all)

From the Godot Platformer Demo README: 
> It shows you how to code characters and physics-based objects
in a real game context. This is a relatively complete demo
where the player can jump, walk on slopes, fire bullets,
interact with enemies, and more. It contains one closed
level, and the player is invincible, unlike the enemies.

> You will find most of the demo’s content in the `Level.tscn` scene.
You can open it from the default `Game.tscn` scene, or double
click on `Level.tscn` in the `src/Level/` directory.

> We invite you to open the demo's GDScript files in the editor as
they contain a lot of comments that explain how each class works.

> **Features:**
> - Side-scrolling player controller using [`KinematicBody2D`](https://docs.godotengine.org/en/latest/classes/class_kinematicbody2d.html).
>     - Can walk on and snap to slopes.
>     - Can shoot, including while jumping.
> - Enemies that crawl on the floor and change direction when they encounter an obstacle.
> - Camera that stays within the level’s bounds.
> - Supports keyboard and gamepad controls.
> - Platforms that can move in any direction.
> - Gun that shoots bullets with rigid body (natural) physics.
> - Collectible coins.
> - Pause and pause menu.
> - Pixel art visuals.
> - Sound effects and music.

## CI
Using https://github.com/marketplace/actions/godot-ci
* https://github.com/abarichello/godot-ci 
* https://hub.docker.com/r/barichello/godot-ci


Tutorial for setting it up: https://dev.to/jeremyckahn/automating-godot-game-releases-to-itchio-1a96 
* https://gist.github.com/jeremyckahn/ff4f0e409f089ec36bdecb5a5adb6819
* https://github.com/aBARICHELLO/godot-ci/blob/master/.github/workflows/godot-ci.yml#L8-99

Butler:
* https://github.com/marketplace/actions/butler-push?version=v1.0.2
* https://github.com/manleydev/butler-publish-itchio-action