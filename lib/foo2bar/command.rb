require "rubygems"
require "foo2bar/namespace"
require "foo2bar/version"
require "foo2bar/util"
require "clamp"
require "foo2bar"

# The main foo2bar command entry point
class Foo2bar::Command < Clamp::Command
  include Foo2bar::Util

  def help(*args)
    lines = [
      "This is foo2bar version #{Foo2bar::VERSION}"
    ]
    lines.push("")
    lines.push(super)
    return lines.join("\n")
  end # def help

  loglevels = %w(error warn info debug)
  option "--log", "LEVEL", "Set the log level. Values: #{loglevels.join(", ")}.",
    :attribute_name => :log_level do |val|
    val.downcase.tap do |v|
      if !loglevels.include?(v)
        raise Foo2bar::Mediafile::InvalidArgument, "Invalid log level, #{v.inspect}. Must be one of: #{loglevels.join(", ")}"
      end
    end
  end # --log
  option "--verbose", :flag, "Enable verbose output"
  option "--debug", :flag, "Enable debug output"

  # A new FPM::Command
  def initialize(*args)
    super(*args)
    @config_files = []
    @directories = []
  end # def initialize

  # Execute this command. See Clamp::Command#execute and Clamp's documentation
  def execute

    logger.level = :warn
    logger.level = :info if verbose? # --verbose
    logger.level = :debug if debug? # --debug
    if log_level
      logger.level = log_level.to_sym
    end

    validator = Validator.new(self)
    if !validator.ok?
      validator.messages.each do |message|
        logger.warn(message)
      end

      logger.fatal("Fix the above problems.")
      return 1
    end
  end # def execute

  def run(*args)
    logger.subscribe(STDOUT)

    super(*args)
  end # def run

  class Validator
    include Foo2bar::Util
    private

    def initialize(command)
      @command = command
      @valid = true
      @messages = []

      validate
    end # def initialize

    def ok?
      return @valid
    end # def ok?

    def validate  
      #mandatory(@command.args.any? || @command.inputs || @command.input_type == 'empty',
      #          "No parameters given. You need to pass additional command " \
      #          "arguments so that I know what you want to build packages " \
      #          "from. For example, for '-s dir' you would pass a list of " \
      #          "files and directories. For '-s gem' you would pass a one" \
      #          " or more gems to package from. As a full example, this " \
      #          "will make an rpm of the 'json' rubygem: " \
      #          "`fpm -s gem -t rpm json`")
    end # def validate

    def mandatory(value, message)
      if value.nil? or !value
        @messages << message
        @valid = false
      end
    end # def mandatory

    def messages
      return @messages
    end # def messages

    public(:initialize, :ok?, :messages)
  end # class Validator
end # class Foo2bar::Command