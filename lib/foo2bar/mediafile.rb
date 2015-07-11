require "foo2bar/namespace"
require "foo2bar/util"
require "cabin" # gem "cabin"

# This class is the parent of all files that will be read or written
class Foo2bar::Mediafile
  include Foo2bar::Util
  include Cabin::Inspectable

  # This class is raised if there's something wrong with a setting in the package.
  class InvalidArgument < StandardError; end

end # Foo2bar::Mediafile