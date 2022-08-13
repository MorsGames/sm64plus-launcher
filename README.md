# SM64 Plus Launcher

This is the repository of the launcher for [SM64Plus](https://github.com/MorsGames/sm64plus), made using GameMaker 2022.2.

Originally I intended to release the source code for it at SM64Plus's initial launch, but as I was working on the launcher the code for it started getting messier and messier, and I always told myself that I'd release it once I refactored it and made it more presentable.

This never happened, so I'm releasing the code as is. There are a lot of improvements that can be made with the code at places, but it gets the job done well regardless.

## Why GameMaker?

I could build all the functionality of the launcher directly into the game, but I chose to go with GameMaker for a few reasons:

- GameMaker is an engine I've been using for years, and it's what I'm most familiar with.
- Using C/C++ and building most of the launcher functionality directly into the game would take way too long, more than I could afford dedicating into a project like this.
- Using something like MonoGame would still take longer, but it would also introduce .NET as a dependency.

## Cons of GameMaker

Using GameMaker paid off in the sense that it saved me a lot of time I would have wasted otherwise, but it also introduced a couple of problems.

- GameMaker does not allow you to launch other executables directly. For this purpose I use [an existing marketplace extension](https://marketplace.yoyogames.com/assets/575/execute-shell), which gets the job done on Windows, but I couldn't get it working under Linux. This is the primary reason why the Linux version of the launcher is not available yet.
- GameMaker doesn't give you a way to convert keyboard inputs to DirectInput keycodes as far as I'm aware, which is why the keyboard binding options are so terrible.
- You cannot get a list of common resolutions your system may support, so you have to manually enter resolution values on the launcher (which is very clunky!).
- The launcher is completely separate from the game itself. This isn't as big of a problem because there would need to be a seperate builder/updater application either way.

All of these issues (except the last) could be solved with a custom C/C++ extension, but this is not something I have the time to look into at the moment. If anyone wants to help on this aspect, please let me know.

## Linux Version?

As mentioned earlier, having a dependency on a marketplace extension prevents me from releasing a functional Linux version of the launcher. Once I solve that issue the Linux launcher will be available. This is also the reason why the Windows launcher is compiled for 32-bit as opposed to 64-bit.

## How to Compile (On Windows)

- #### Step 1:
    [Download and install the latest version of GameMaker.](https://gamemaker.io/en)

- #### Step 2:
    Clone this repository. (We can either use git or the green "Code" button that's at the top right of this page.)

- #### Step 3:
    Open the project in GameMaker.

- #### Step 4:
    Trying to run the launcher directly now would force us to clone the game's repository and recompile the game _every single time_ we want to run the launcher, which is not ideal. In addition, it would try to download the stable branch of the repository, which would likely not work. We need to work with the `dev` branch.

   So we need to manually build the game according to the [Manual Building Guide](https://github.com/MorsGames/sm64plus/wiki/Manual-Building-Guide). The only thing we need to do differently is to use the command `git clone https://github.com/MorsGames/sm64plus.git --branch dev` in step 4 instead.
    
    The folder we choose for the cloned repository doesn't entirely matter, just try not to forget it because we will be needing it later.

- #### Step 5:
    Run the launcher from GameMaker in debug mode, using the bug icon that's right next to the run triangle. It will tell you to enter the repository path to a specific text file. This repository path is the `sm64plus` folder created by the clone command. Do that.

- #### Step 6:
    Run the launcher again the same way, and voila!

## More

[All the information you will need about the base game can be found in its own repository.](https://github.com/MorsGames/sm64plus)
