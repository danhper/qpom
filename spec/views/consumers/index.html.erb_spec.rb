require 'spec_helper'

describe "consumers/index" do
  before(:each) do
    assign(:consumers, [
      stub_model(Consumer),
      stub_model(Consumer)
    ])
  end

  it "renders a list of consumers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
