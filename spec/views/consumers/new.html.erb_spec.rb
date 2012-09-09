require 'spec_helper'

describe "consumers/new" do
  before(:each) do
    assign(:consumer, stub_model(Consumer).as_new_record)
  end

  it "renders new consumer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => consumers_path, :method => "post" do
    end
  end
end
