require 'spec_helper'

describe "groups/edit" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :navn => "MyString",
      :beskrivelse => "MyText"
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", group_path(@group), "post" do
      assert_select "input#group_navn[name=?]", "group[navn]"
      assert_select "textarea#group_beskrivelse[name=?]", "group[beskrivelse]"
    end
  end
end
