require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
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
      ),
      stub_model(Profile,
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
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Shop Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Special Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
