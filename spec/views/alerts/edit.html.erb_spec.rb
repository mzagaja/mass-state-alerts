require 'rails_helper'

RSpec.describe "alerts/edit", type: :view do
  before(:each) do
    @alert = assign(:alert, Alert.create!(
      :title => "MyString",
      :updated => "",
      :body => "MyString"
    ))
  end

  it "renders the edit alert form" do
    render

    assert_select "form[action=?][method=?]", alert_path(@alert), "post" do

      assert_select "input#alert_title[name=?]", "alert[title]"

      assert_select "input#alert_updated[name=?]", "alert[updated]"

      assert_select "input#alert_body[name=?]", "alert[body]"
    end
  end
end
