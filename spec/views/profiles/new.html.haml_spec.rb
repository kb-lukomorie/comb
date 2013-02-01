require 'spec_helper'

describe "profiles/new" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :city => "MyString",
      :shop_name => "MyString",
      :shop_description => "MyText",
      :delivery_in_russia => false,
      :free_delivery => false,
      :self_delivery => false,
      :special_url => "MyString",
      :card_payments => false,
      :cashless => false,
      :account => nil
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path, :method => "post" do
      assert_select "input#profile_city", :name => "profile[city]"
      assert_select "input#profile_shop_name", :name => "profile[shop_name]"
      assert_select "textarea#profile_shop_description", :name => "profile[shop_description]"
      assert_select "input#profile_delivery_in_russia", :name => "profile[delivery_in_russia]"
      assert_select "input#profile_free_delivery", :name => "profile[free_delivery]"
      assert_select "input#profile_self_delivery", :name => "profile[self_delivery]"
      assert_select "input#profile_special_url", :name => "profile[special_url]"
      assert_select "input#profile_card_payments", :name => "profile[card_payments]"
      assert_select "input#profile_cashless", :name => "profile[cashless]"
      assert_select "input#profile_account", :name => "profile[account]"
    end
  end
end
