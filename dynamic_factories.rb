class DynamizeFactories

  def initialize file
    @file = file
    @content = File.read file
  end

  def dynamize data
    value    = data.split(' ', 2)[1]
    new_val  = "{#{value}}"
    "#{data.sub(value, new_val)}"
  end

  def evaluate
    lines    = @content.split("\n")
    lines.each_with_index do |line, index|
      lines[index] = dynamize(line) if line.size.positive? && type(line)
    end
    @result = lines.join("\n")
    @result
  end

  def put_it_back
    evaluate unless @result
    @file = File.new(@file, 'w')
    @file.write(@result)
    @file.close
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