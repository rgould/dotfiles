# Setup:
#
# rvm use <ruby>@global
# gem install awesome_print
# gem install hirb
# gem install interactive_editor
# gem install wirble
#
# Credits to Iain Hecker, http://iain.nl
# Tweaks by Rob Lowe (colors, irb/macirb patch, simple prompt)

require 'rubygems'
require 'yaml'

alias q exit

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

ANSI = {}
ANSI[:RESET] = "\e[0m"
ANSI[:BOLD] = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY] = "\e[0;37m"
ANSI[:GRAY] = "\e[1;30m"
ANSI[:RED] = "\e[31m"
ANSI[:GREEN] = "\e[32m"
ANSI[:YELLOW] = "\e[33m"
ANSI[:BLUE] = "\e[34m"
ANSI[:MAGENTA] = "\e[35m"
ANSI[:CYAN] = "\e[36m"
ANSI[:WHITE] = "\e[37m"

# Lazy hack for irb / macirb
if !defined?(RUBY_ENGINE)

  # Build a simple colorful IRB prompt
  IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
    :PROMPT_I => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
    :PROMPT_N => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
    :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
    :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
    :RETURN   => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
    :AUTO_INDENT => true
  }
  IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

end

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, care = true, required = true)
  if care
    require name if required
    yield if block_given?
    $console_extensions << "#{ANSI[:GREEN]}#{name}#{ANSI[:RESET]}"
  else
    $console_extensions << "#{ANSI[:GRAY]}#{name}#{ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{ANSI[:RED]}#{name}#{ANSI[:RESET]}"
end
$console_extensions = []


# Wirble is a gem that handles coloring the IRB
# output and history
extend_console 'wirble' do

  # colors:
  #
  # :nothing        :green            :light_purple
  # :black          :light_blue       :purple
  # :blue           :light_cyan       :red
  # :brown          :light_gray       :white
  # :cyan           :light_green      :yellow
  # :dark_gray      :light_red

  colors = Wirble::Colorize.colors.merge({
    # delimiter colors
    :comma              => :white,
    :refers             => :white,

    # container colors (hash and array)
    :open_hash          => :grey,
    :close_hash         => :grey,
    :open_array         => :grey,
    :close_array        => :grey,

    # object colors
    :open_object        => :light_red,
    :object_class       => :white,
    :object_addr        => :cyan,
    :object_addr_prefix => :cyan,
    :object_line_prefix => :cyan,
    :close_object       => :light_red,

    # symbol colors
    :symbol             => :white,
    :symbol_prefix      => :white,

    # string colors
    :open_string        => :red,
    :string             => :red,
    :close_string       => :red,

    # misc colors
    :number             => :cyan,
    :keyword            => :green,
    :class              => :light_green,
    :range              => :cyan
  })
  # set the colors used by Wirble
  Wirble::Colorize.colors = colors

  Wirble.init
  Wirble.colorize
end

# Hirb makes tables easy.
extend_console 'hirb' do
  Hirb.enable
  extend Hirb::Console
end

# awesome_print is prints prettier than pretty_print
extend_console 'awesome_print' do
  alias pp ap
end

# When you're using Rails 2 console, show queries in the console
extend_console 'rails2', (ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')), false do
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# When you're using Rails 3 console, show queries in the console
extend_console 'rails3', defined?(ActiveSupport::Notifications), false do
  $odd_or_even_queries = false
  ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
    $odd_or_even_queries = !$odd_or_even_queries
    color = $odd_or_even_queries ? ANSI[:CYAN] : ANSI[:MAGENTA]
    event = ActiveSupport::Notifications::Event.new(*args)
    time = "%.1fms" % event.duration
    name = event.payload[:name]
    sql = event.payload[:sql].gsub("\n", " ").squeeze(" ")
    puts " #{ANSI[:UNDERLINE]}#{color}#{name} (#{time})#{ANSI[:RESET]} #{sql}"
  end
end

# Add a method pm that shows every method on an object
# Pass a regex to filter these
extend_console 'pm', true, false do
  def pm(obj, *options) # Print methods
    methods = obj.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = obj.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name.to_s, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI[:YELLOW]}#{item[0].to_s.rjust(max_name)}#{ANSI[:RESET]}"
      print "#{ANSI[:BLUE]}#{item[1].ljust(max_args)}#{ANSI[:RESET]}"
      print " #{ANSI[:GRAY]}#{item[2]}#{ANSI[:RESET]}\n"
    end
    data.size
  end
end

extend_console 'interactive_editor' do
  # no configuration needed
end

# Show results of all extension-loading
puts "#{ANSI[:GRAY]}~> Console extensions:#{ANSI[:RESET]} #{$console_extensions.join(' ')}#{ANSI[:RESET]}"

IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:SAVE_HISTORY] = 1000

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

class Object
  def my_methods(include_inherited = false)
    ignored_methods = include_inherited ? Object.methods : self.class.superclass.instance_methods
    (self.methods - ignored_methods).sort
  end
  alias_method :m, :my_methods
end


######### RAILS 3 ONLY

if defined?(ActiveSupport::Notifications)

  def reload_factories!
    reload!
    Factory.factories= {}
    Dir.glob("#{Rails.root}/{test,spec}/factories/*.rb").each { |f| load f }

    # clear out any tables that we have factories for
    Factory.factories.values.map(&:class_name).uniq.each do |class_name|
      class_name.to_s.camelize.constantize.delete_all
    end
  end

  def reload_blueprints!
    reload!
    load    "#{Rails.root}/spec/blueprints.rb"
  end

  # Autoload blueprints
  begin
    require "#{Rails.root}/spec/blueprints"
  rescue LoadError; end

end


