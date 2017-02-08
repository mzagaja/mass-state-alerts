require 'rails_helper'

RSpec.describe "alerts/index", type: :view do
  before(:each) do
    assign(:alerts, [
      Alert.create!(
        :title => "Title",
        :updated => "",
        :body => "Body"
      ),
      Alert.create!(
        :title => "Title",
        :updated => "",
        :body => "Body"
      )
    ])
  end

  it "renders a list of alerts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
