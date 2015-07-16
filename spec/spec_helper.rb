$: << File.join(File.dirname(__FILE__), '..', 'lib')
 
require 'pry'
require 'foo2bar'

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end