require File.join(File.dirname(__FILE__), "lib/foo2bar/version")
Gem::Specification.new do |spec|
  files = []
  dirs = %w{lib bin}
  dirs.each do |dir|
    files += Dir["#{dir}/**/*"]
  end

  files << "LICENSE"
  files << "CONTRIBUTORS"
  files << "CHANGELOG"

  spec.name = "foo2bar"
  spec.version = Foo2bar::VERSION
  spec.summary = "foo2bar - audio file conversion"
  spec.description = "Convert audio files from one format to another, " \
    "including audio data, tags, etc. " \
    "Evolved from flac2mp3.pl"
  spec.license = "GPL-3.0"

  # For parsing JSON (required for some Python support, etc)
  # http://flori.github.com/json/doc/index.html
  #spec.add_dependency("json", ">= 1.7.7") # license: Ruby License
  
  # For logging
  # https://github.com/jordansissel/ruby-cabin
  spec.add_dependency("cabin", ">= 0.6.0") # license: Apache 2 

  # For backports to older rubies
  # https://github.com/marcandre/backports
  #spec.add_dependency("backports", ">= 2.6.2") # license: MIT

  # For reading and writing rpms
  #spec.add_dependency("arr-pm", "~> 0.0.10") # license: Apache 2

  # For command-line flag support
  # https://github.com/mdub/clamp/blob/master/README.markdown
  spec.add_dependency("clamp", "~> 0.6") # license: MIT

  # For starting external processes across various ruby interpreters
  #spec.add_dependency("childprocess") # license: ???

  # For calling functions in dynamic libraries
  #spec.add_dependency("ffi") # license: GPL3/LGPL3

  spec.add_development_dependency("rspec", "~> 3.0.0") # license: MIT (according to wikipedia)
  spec.add_development_dependency("guard")
  spec.add_development_dependency("guard-rspec")
  spec.add_development_dependency("pry")
  #spec.add_development_dependency("insist", "~> 0.0.5") # license: ???
  #spec.add_development_dependency("stud")

  spec.files = files
  spec.require_paths << "lib"
  spec.bindir = "bin"
  spec.executables << "foo2bar"

  spec.author = "Robin Bowes"
  spec.email = "robin.bowes@yo61.com"
  spec.homepage = "https://github.com/robinbowes/foo2bar"
end

