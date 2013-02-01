require 'spec_helper'

describe "profiles/show" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :city => "City",
      :shop_name => "Shop Name",
      :shop_description => "MyText",
      :delivery_in_russia => false,
      :free_delivery => false,
      :self_delivery => false,
      :special_url => "Special Url",
      :card_payments => false,
      :cashless => false,
      :account => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    rendered.should match(/Shop Name/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/Special Url/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(//)
  end
end
