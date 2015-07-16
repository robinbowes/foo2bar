require "spec_helper"
require "foo2bar/command"


describe "Foo2bar::Command" do

  let(:cmd) { Foo2bar::Command.new("foo2bar") }

  subject { cmd }

  context "when run without arguments" do
    let(:expected_output) { 'Summary' }
    let(:output) { capture_stdout { cmd.run([]) } }
    it "should display a usage summary" do
      output.should include(expected_output)
    end
  end
end