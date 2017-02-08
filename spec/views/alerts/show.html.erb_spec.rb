require 'rails_helper'

RSpec.describe "alerts/show", type: :view do
  before(:each) do
    @alert = assign(:alert, Alert.create!(
      :title => "Title",
      :updated => "",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Body/)
  end
end
