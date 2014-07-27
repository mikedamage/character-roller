# Character Roller

by Mike Green

_A d20 ablity score generator and all-around Swiss Army Knife for RPG geeks_

[![Gem Version](https://badge.fury.io/rb/character-roller.svg)](http://badge.fury.io/rb/character-roller)

## About

I started this project as a quick way to generate ability scores for NPCs, and I ended up with a decent CLI dice roller in the process. I expect it'll only appeal to RPG geeks who also dig the command line.

**NOTE:** This program requires an Internet connection. It utilizes the [TrueRandom][true_random] library to get actual random numbers from [Random.org][random_org].

## Installation

The quickest way to install Character Roller is via Rubygems:
```shell
[sudo] gem install character-roller
```

You can also install from this repo's master branch:
```shell
git clone https://github.com/mikedamage/character-roller.git
cd character-roller
bundle install
rake build
rake install
```

Alternately, `bin/dice` can just be run from the project directory once dependencies are installed.

```bash
bundle install
./bin/dice 4d6
```

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

### Examples

`dice`'s default behavior depends on its arguments. Given none, it prints its version and exits.
```
$ dice
Character Roller v0.1.2
```

Given a "ndn" string (i.e. 4d6), `dice` will roll and show you the resulting sum:
```
$ dice 4d6
15
```

If you use the `roll` subcommand you can get more details, like the result of each individual die roll:
```
$ dice roll 4d6 -s
[4, 5, 1, 1]
11
```

You can also add a bonus to the randomly determined total:
```
dice roll 8d12+12 -s
[10, 10, 1, 7, 11, 9, 2, 2] + 12 = 64
```

You can generate a single ability score (roll 4d6, re-roll 1's, and drop the lowest die):
```
$ dice ability_score --show-results --bonus
[3, 4, 5] = 12	(+1)
```

Generate all 6 of a character's ability scores at once:
```
$ dice ability_scores --show-results --bonuses
[6, 6, 6] = 18	(+4)
[3, 5, 6] = 14	(+2)
[2, 3, 4] = 9	(-1)
[3, 5, 6] = 14	(+2)
[3, 4, 6] = 13	(+1)
[4, 5, 6] = 15	(+2)
```

[random_org]: http://random.org/
[true_random]: https://github.com/mabarroso/true-random
