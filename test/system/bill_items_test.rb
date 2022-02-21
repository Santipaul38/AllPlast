require "application_system_test_case"

class BillItemsTest < ApplicationSystemTestCase
  setup do
    @bill_item = bill_items(:one)
  end

  test "visiting the index" do
    visit bill_items_url
    assert_selector "h1", text: "Bill items"
  end

  test "should create bill item" do
    visit bill_items_url
    click_on "New bill item"

    click_on "Create Bill item"

    assert_text "Bill item was successfully created"
    click_on "Back"
  end

  test "should update Bill item" do
    visit bill_item_url(@bill_item)
    click_on "Edit this bill item", match: :first

    click_on "Update Bill item"

    assert_text "Bill item was successfully updated"
    click_on "Back"
  end

  test "should destroy Bill item" do
    visit bill_item_url(@bill_item)
    click_on "Destroy this bill item", match: :first

    assert_text "Bill item was successfully destroyed"
  end
end
