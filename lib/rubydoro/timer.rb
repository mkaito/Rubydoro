module Rubydoro
  class Timer
    def first(&block)
      @first = block
    end

    def last(&block)
      @last = block
    end

    def step(&block)
      @step = block
    end

    def run(steps)
      @first.call steps

      while steps > 0 do
        @step.call steps
        sleep 1
        steps -= 1
      end

      @last.call
    end # def timer
  end # class Timer
end
