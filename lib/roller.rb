require 'thor'

class Roller < Thor
  include Thor::Actions

  desc 'roll NdN', 'Rolls N, N-sided dice and returns the total result'
  def roll(ndn)
    match_reg = %r{(\d+)[dD](\d+)}
    matches   = match_reg.match ndn

    if matches.length === 3
      dice  = matches[1].to_i
      sides = matches[2].to_i
      total = 0

      dice.times do
        total += roll_one_die sides
      end

      say total
    else
      say "Invalid input", :red
      exit
    end
  end

  desc 'ability_score', 'Rolls an ability score (4d6, discard lowest, re-roll 1s)'
  def ability_score
    results = []

    4.times do
      results << roll_one_die(6, true)
    end

    results.sort!.shift

    say results.reduce :+
  end

  no_tasks do
    def roll_one_die(sides, ignore_ones = false)
      range  = (1..sides).to_a.shuffle
      result = range.first

      if result === 1 && ignore_ones
        result = roll_one_die sides, true
      end

      result
    end
  end
end

# vim: set ts=2 sw=2 expandtab :
