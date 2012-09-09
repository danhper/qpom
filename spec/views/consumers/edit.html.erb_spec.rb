require 'spec_helper'

describe "consumers/edit" do
  before(:each) do
    @consumer = assign(:consumer, stub_model(Consumer))
  end

  it "renders the edit consumer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => consumers_path(@consumer), :method => "post" do
    end
  end
end
