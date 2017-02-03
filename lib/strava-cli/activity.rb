module StravaCli
  class Activity
    attr_accessor :type, :duration, :time, :distance

    def to_s
      [type, time, duration, distance].join(", ")
    end
  end
end