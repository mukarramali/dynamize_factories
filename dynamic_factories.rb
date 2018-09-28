class DynamizeFactories

  def initialize file
    @content = File.read file
  end

  def dynamize data
    attribute       = data.split.first
    attribute_index = data.index(attribute)
    attr_last_index = attribute_index+attribute.size
    value           = data[attr_last_index..-1].strip
    pre_padding     = pad(attribute_index)
    in_padding      = pad(data.index(value) - attr_last_index)
    "#{pre_padding}#{attribute}#{in_padding}{#{value}}"
  end

  def eval
    lines = @content.split("\n")
    lines.each_with_index do |line, index|
      lines[index] = dynamize(line) if line.size.positive? && type(line)
    end
    lines.join("\n")
  end

  private

    def type data
      return false if data.include?('FactoryBot.define') || # CLASS_BEGIN
                      data.strip == 'end' ||                # END block
                      data.strip[0] == '#' ||               # Comment
                      data[-1] == '}' ||                    # DYNAMIC value
                      (data.include?('factory :') && (data.split.last == 'do' || data[-1] == '|')) # Do block
      true  # Static assignment
    end

    def pad count
      " "*count
    end
end