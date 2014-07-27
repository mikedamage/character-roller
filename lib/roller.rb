require 'json'
require 'net/http'
require 'uri'
require 'thor'

# [todo] - check for internet connectivity. If none, fallback to SecureRandom
require 'true-random'

class Roller < Thor
  include Thor::Actions

  JSONIP_URL  = "http://jsonip.com/"
  NDN_PATTERN = %r{(\d+)[dD](\d+)\+?(\d+)?}

  default_task :version

  class_option :show_results,
    type: :boolean,
    default: false,
    desc: "Show each die roll result",
    aliases: [ '-s' ]

  desc 'version', 'Display version information'
  def version
    ver = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp!
    say "Character Roller v#{ver.to_s}"
  end

  desc 'roll NdN', 'Rolls N, N-sided dice and returns the total result'
  def roll(ndn)
    matches = NDN_PATTERN.match ndn
    bonus   = 0

    if matches.length === 4
      dice  = matches[1].to_i
      sides = matches[2].to_i
      bonus = matches[3].to_i if matches[3]

      rolls  = roll_dice dice, sides
      total  = rolls.reduce :+
      total += bonus

      if options.show_results
        print rolls.to_s
        print " + #{bonus.to_s}"
        print " = #{total}\n"
      else
        say total
      end
    else
      say "Invalid input", :red
      exit
    end
  end

  desc 'ability_score', 'Rolls an ability score (4d6, discard lowest, re-roll 1s)'
  method_option :bonus,
    type: :boolean,
    desc: "Show the score's bonus",
    default: false,
    aliases: %w( -b )
  def ability_score
    roll = roll_ability_score

    if options.show_results
      print roll[:results].to_s + " = "
    end

    print roll[:total].to_s

    if options.bonus
      bonus = calculate_bonus roll[:total], true
      print "\t(#{bonus})\n"
    else
      print "\n"
    end
  end

  desc 'ability_scores', 'Rolls 6 ability scores'
  method_option :bonuses,
    type: :boolean,
    desc: "Show the scores' bonuses",
    default: false,
    aliases: %w( -b )
  def ability_scores
    6.times do
      res = roll_ability_score

      if options.show_results
        print res[:results].to_s + " = "
      end

      print res[:total]

      if options.bonuses
        bonus = calculate_bonus res[:total], true
        print "\t(#{bonus})\n"
      else
        print "\n"
      end
    end
  end

  desc 'bonus SCORE', 'Show the bonus granted by an ability score'
  def bonus(score)

    begin
      score = score.to_i
    rescue
      say 'Score must be an integer!', :red
      exit 1
    end

    if score < 1
      say 'Score must be greater than 0!', :red
      exit 2
    end

    bonus = calculate_bonus score, true
    say bonus
  end

  private

  def roll_dice(ndice = 1, nsides = 6, ignore_ones = false)
    rander  = TrueRandom::Random.new
    results = rander.integer ndice, 1, nsides
    results = [results] unless results.is_a? Array

    if ignore_ones && results.include?(1)
      results.delete_if {|n| n === 1 }
      diff     = ndice - results.size
      new_ints = roll_dice diff, nsides, ignore_ones
      results.concat new_ints
    end

    results
  end

  def roll_ability_score
    results = {
      results: [],
      total: 0
    }

    results[:results] = roll_dice 4, 6, true

    results[:results].sort!.shift
    results[:total] = results[:results].reduce :+

    results
  end

  def calculate_bonus(score, as_string = false)
    bonus = score / 2 - 5

    if as_string
      str  = if bonus > 0 then "+" else "" end
      str += bonus.to_s
      return str
    end

    bonus
  end

  def check_quota
    rander = TrueRandom::Random.new
    rander.quota get_external_ip
  end

  def get_external_ip
    uri  = URI.parse JSONIP_URL
    resp = Net::HTTP.get_response uri

    if resp.is_a? Net::HTTPOK
      json = JSON.parse resp.body
      return json['ip']
    end

    nil
  end
end

# vim: set ts=2 sw=2 expandtab :
