module StravaCli
  class Command
    Error = Class.new(StandardError)

    def initialize(argv = [])
      @argv = argv
    end

    def run
      parse(argv)
      puts "strava-cli"
      puts "type: #{type}"
      puts "duration: #{duration}"
      puts "time: #{time}"
    rescue Error => error
      puts error.message
    end

    private
    attr_reader :argv
    attr_reader :type, :time, :duration

    def parse(argv)
      command = argv[0]
      raise Error.new("Unsuported command: #{command}") unless command == "add"
      @type = argv[1]
      OptionParser.new(argv) do |parser|
        parser.on("-t", "--time TIME", "Date of the activity") do |v|
          @time = Chronic.parse(v)
        end
        parser.on("-d", "--duration DURATION", "Duration of the activity") do |v|
          @duration = ChronicDuration.parse(v)
        end
      end.parse!
      raise Error.new("Invalid options") if duration.nil? || time.nil?
    end
  end
end