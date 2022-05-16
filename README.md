# SM64 Plus Launcher

This is the repository for the launcher for [SM64Plus](https://github.com/MorsGames/sm64plus), written using GameMaker 2022.2.

Originally I intended to release the source code for it at SM64Plus's initial launch, but as I was working on the launcher the code for it started getting messier and messier, and I always told myself that I'd release it once I refactored it and made it more presentable.

This never happened, so I'm releasing the code as is. There are a lot of improvements that can be made with it, but it gets the job done rather well.

## Why GameMaker?

I could build all the functionality of the launcher directly into the game, but I chose to go with GameMaker because for a few reasons:

- GameMaker is an engine I've been using for years, and it's what I'm most familiar with.
- Using C/C++ and building the launcher functionality directly into the game would take way too long, more than I could afford dedicating into a project like this.
- Using something like MonoGame would still take longer, but it would also introduce .NET as a dependency.

## Cons of GameMaker

Using GameMaker paid off in the sense that it saved me a lot of time I would have wasted otherwise, but it also introduced a couple of problems.

- GameMaker does not allow you to launch other executables directly. For this purpose I use [an existing marketplace extension](https://marketplace.yoyogames.com/assets/575/execute-shell), which gets the job done on Windows, but I couldn't get it working under Linux. This is the primary reason why the Linux version of the launcher is not available yet.
- GameMaker doesn't give you a way to convert keyboard inputs to DirectInput keycodes as far as I'm aware, which is why the keyboard binding options are so terrible.
- You cannot get a list of common resolutions the system supports, so you have to manually enter the values on the launcher (which is very clunky!).
- The launcher is completely separate from the game itself. This isn't as big of a problem because there would need to be a seperate builder/updater application either way.

All these issues (except the last) can be solved with a custom C/C++ extension, but this is not something I have the time to look into at the moment. If anyone wants to help on this aspect, please let me know.

## Linux Version?

As mentioned earlier, having a dependency on a marketplace extension prevents me from releasing a functional Linux version of the launcher. Once I solve that issue the Linux launcher will be available. This is also the reason why the Windows launcher is compiled for 32-bit.

## How to Compile

- #### Step 1:
    [Download and install the latest version of GameMaker.](https://gamemaker.io/en)

- #### Step 2:
    Clone this repository. (You can either use git or the green "Code" button that's on top right.)

- #### Step 3:
    Open the project in GameMaker.

- #### Step 4:
    Run the build.

- #### Step 5:
    ????

- #### Step 6:
    Profit?
    
    Actually, no. You cannot really use the launcher directly after cloning repository since you _have to_ use it with an already cloned repository of the `dev` branch of the actual game, as well as an existing build. Most of the time trying to pair the latest commit of launcher with the stable branch game will give unintended results, and trying to run the game directly would just force you to clone the game's repository and recompile the game _every single time_.

    Instead you need to manually build the game according to the [Manual Building Guide](https://github.com/MorsGames/sm64plus/wiki/Manual-Building-Guide). The only thing you need to do differently is to use the command `git clone https://github.com/MorsGames/sm64plus.git --branch dev` instead of what's written there. The folder you choose for the cloned repository doesn't entirely matter, just try not to forget it because we will be needing it later.

- #### Step 7:
    Run the game from GameMaker in debug mode, using the lil' bug icon* that's right next to the triangle. It will tell you to enter the repository path to a specific text file. This repository path is the `sm64plus` folder created by the clone command. Do that.

- #### Step 8:
    Run the game again in the same way, and voila!

_\*I do not know if there's a rapper called Lil' Bug. If there is, then ignore what I said. It's an actual bug icon, not some rapper dude from Boston._

## More

[All the information you will need about the base game is on its own repository.](https://github.com/MorsGames/sm64plus)