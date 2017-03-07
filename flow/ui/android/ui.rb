module UI
  def self.context
    @context or raise "Context missing"
  end

  def self.context=(context)
    @context = context
  end

  def self.density
    @density ||= UI.context.resources.displayMetrics.density
  end

  def self.resource_str(name)
    if stream = UI.context.assets.open(name)
      input_reader = Java::Io::InputStreamReader.new(stream)
      input = Java::Io::BufferedReader.new(input_reader)
      buf = Java::Lang::StringBuffer.new
      loop do
        break unless line = input.readLine
        buf.append(line)
      end
      input.close
      buf.toString
    end
  end
end
