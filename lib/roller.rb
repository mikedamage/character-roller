require 'thor'

class Roller < Thor
  include Thor::Actions

  desc 'roll NdN', 'Rolls N, N-sided dice and returns the total result'
  method_option :show_results, type: :boolean, default: false
  def roll(ndn)
    match_reg = %r{(\d+)[dD](\d+)}
    matches   = match_reg.match ndn
    results   = []

    if matches.length === 3
      dice  = matches[1].to_i
      sides = matches[2].to_i
      total = 0

      dice.times do
        result = roll_one_die sides
        results << result
        total += result
      end

      p results if options.show_results
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

  desc 'ability_scores', 'Rolls 6 ability scores'
  def ability_scores
    6.times do
      ability_score
    end
  end

  no_tasks do
    def roll_one_die(sides, ignore_ones = false)
      result = 1 + Random.rand(sides)

      if result === 1 && ignore_ones
        result = roll_one_die sides, true
      end

      result
    end
  end
end

# vim: set ts=2 sw=2 expandtab :
