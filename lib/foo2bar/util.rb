require "foo2bar/namespace"

# utility functions
module Foo2bar::Util

  def logger
    @logger ||= Cabin::Channel.get
  end # def logger

end # module Foo2bar::Util