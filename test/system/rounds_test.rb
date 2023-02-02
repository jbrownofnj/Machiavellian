require "application_system_test_case"

class RoundsTest < ApplicationSystemTestCase
  setup do
    @round = rounds(:one)
  end

  test "visiting the index" do
    visit rounds_url
    assert_selector "h1", text: "Rounds"
  end

  test "should create round" do
    visit rounds_url
    click_on "New round"

    fill_in "Match", with: @round.match_id
    click_on "Create Round"

    assert_text "Round was successfully created"
    click_on "Back"
  end

  test "should update Round" do
    visit round_url(@round)
    click_on "Edit this round", match: :first

    fill_in "Match", with: @round.match_id
    click_on "Update Round"

    assert_text "Round was successfully updated"
    click_on "Back"
  end

  test "should destroy Round" do
    visit round_url(@round)
    click_on "Destroy this round", match: :first

    assert_text "Round was successfully destroyed"
  end
end
