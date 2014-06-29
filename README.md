# Character Roller

by Mike Green

_A d20 ablity score generator and all-around Swiss Army Knife for RPG geeks_

## About

I started this project as a quick way to generate ability scores for NPCs, and I ended up with a decent CLI dice roller. Of course the results can't be truly random, but it works just fine for the random allies and enemies your players may encounter.

## Installation

When Character Roller is a little more polished I'll put it up on rubygems.org. Until then it's easy to build and install manually. Alternately, `bin/dice` can just be run from the project directory once dependencies are installed.

```bash
bundle install
rake install
```

Once `rake install` is run, you'll have a `dice` executable in your `PATH`.

## Usage

`bin/dice` is the main executable. You can see which commands are available by running `dice help`. Get detailed info on a command by running `dice help COMMAND`.

    Commands:
      dice ability_score   # Rolls an ability score (4d6, discard lowest, re-roll 1s)
      dice ability_scores  # Rolls 6 ability scores
      dice bonus SCORE     # Show the bonus granted by an ability score
      dice help [COMMAND]  # Describe available commands or one specific command
      dice roll NdN        # Rolls N, N-sided dice and returns the total result
      dice version         # Display version information

    Options:
      -s, [--show-results], [--no-show-results]  # Show each die roll result
