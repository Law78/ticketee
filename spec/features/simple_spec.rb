module SimpleTest
  def self.SimpleTest
    "Hello World"
  end
end


describe SimpleTest do
  context "Greetings" do
      it "say Hello World" do
        expect(SimpleTest.SimpleTest()).to eql("Hello World")
      end
    end
end
