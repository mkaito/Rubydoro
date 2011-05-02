require 'rubydoro/timer'

module Rubydoro
  class CLI
    def initialize(opts)
      @opts = opts
      @timer = Rubydoro::Timer.new
      @timer.first { |d| puts "[#{colorize Time.now.strftime('%H:%M'), :blue}] Pomodoro started! You have #{ display_time(d) }."}
      @timer.last { puts "\r[#{colorize Time.now.strftime('%H:%M'), :blue}] Time over!                         "}
      @timer.step { |t| print "\rTime left: #{ colorize display_time(t), (t > 299 ? :green : :red) }"}
    end

    def run
      # Always run the initial pomodoro
      @timer.run parse_time(@opts[:pomodoro])

      # Run a break timer unless we're asked to skip it
      @timer.run parse_time(@opts[:break]) unless @opts[:skip]

      # Loop recursively if asked to
      run if @opts[:loop]
    end

    def display_time(t)
      time = case t
             when 0..59 
               [t]
             when 60..3599
               [t/60, t%60]
             when 3600..86399
               [t/3600, t%3600/60, t%3600%60]
             end

      time.map! { |v|v.to_s.rjust(2, '0') }
      time.join(":")
    end

    def parse_time(t)
      case t[-1]
      when "s" then t.to_i
      when "h" then t.to_i * 60 * 60
        # "m" or nothing
      else t.to_i * 60
      end
    end

    def colorize(text, fg=:default, bg=:default)
      text unless @opts[:colorize]
      fge = case fg
            when :black then 30
            when :red then 31
            when :green then 32
            when :yellow then 33
            when :blue then 34
            when :magenta then 35
            when :cyan then 36
            when :white then 37
            else 39
            end

      bge = case bg
            when :black then 40
            when :red then 41
            when :green then 42
            when :yellow then 43
            when :blue then 44
            when :magenta then 45
            when :cyan then 46
            when :white then 47
            else 49
            end

      "\e[#{fge}m\e[#{bge}m#{text}\e[0m"
    end

  end
end
