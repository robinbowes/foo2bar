require "spec_helper"
require "foo2bar/command"

describe "Foo2bar::Command" do
  context "when run without arguments" do
    it "should display a usage summary" do
      cmd = Foo2bar::Command.new("foo2bar")
      cmd.run([])
    end
  end
end