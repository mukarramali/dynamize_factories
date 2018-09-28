module Constants
  CLASS_BEGIN = 0
  DO_BLOCK = 1
  ENDED = 2
  STATIC = 4
  DYNAMIC = 5
  COMMENT = 6
end

include Constants

def type data
  return CLASS_BEGIN if data.include?'FactoryBot.define do'
  return DO_BLOCK if data.include?('factory :') && (data.split.last == 'do' || data[-1] == '|')
  return ENDED if data.strip == 'end'
  return DYNAMIC if data[-1] == '}' && data.include?('{')
  return COMMENT if data.strip[0] == '#'
  return STATIC
end

def pad count
  " "*count
end

def dynamize data
  attribute   = data.split.first
  value       = data[(data.index(attribute)+attribute.size)..-1].strip
  pre_padding = pad(data.index(attribute))
  in_padding  = pad(data.index(value) - (data.index(attribute)+attribute.size))
  "#{pre_padding}#{attribute}#{in_padding}{#{value}}"
end

def dynamize_factories content
  lines = content.split("\n")
  lines.each_with_index do |line, index|
    lines[index] = dynamize(line) if line.size.positive? && type(line) == STATIC
  end
  lines.join("\n")
end

data = "FactoryBot.define do

  # knadknskd

  factory :signal_patterns_feedback do
    personality_score_id              1
    factor_id                         5
    facet_score                       {\"#<BigDecimal:7fd6d4e5a4b8,'0.525E1',18(18)>\"}
    created_at                        '2010-05-10 12:09:09'
    updated_at                        '2010-05-10 12:09:09'
  end
end
"

puts "=======Before========="
puts data
puts "\n\n"
puts "=======After========="
puts dynamize_factories(data)