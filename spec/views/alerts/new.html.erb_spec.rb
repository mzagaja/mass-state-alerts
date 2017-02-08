require 'rails_helper'

RSpec.describe "alerts/new", type: :view do
  before(:each) do
    assign(:alert, Alert.new(
      :title => "MyString",
      :updated => "",
      :body => "MyString"
    ))
  end

  it "renders new alert form" do
    render

    assert_select "form[action=?][method=?]", alerts_path, "post" do

      assert_select "input#alert_title[name=?]", "alert[title]"

      assert_select "input#alert_updated[name=?]", "alert[updated]"

      assert_select "input#alert_body[name=?]", "alert[body]"
    end
  end
end
