require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Inputing a random word gives you not in grid message" do
    visit new_url
    fill_in "guess", with: "abandonment"
    click_on "submit"

    assert_text "can't be built out of"
  end

  test "Inputing a random string from the suggested letters gives you an not an english word message" do
    visit new_url
    fill_in "guess", with: "djfvblkfjdvblfdjbdf"
    click_on "submit"

    assert_text "does not seem to be a valid English word"
  end

  test "Congratulates the player for a valid guess" do
    visit new_url
    fill_in "guess", with: "A"
    # fill_in "letters", with: "ABCDEFGHI"
    # find(:xpath, "//input[@id='guess']").set "A"
    first('input#id.class', visible: false).set("ABCDEFGHI")
    # find_field('letters').set("ABCDEFGHI")
    click_on "submit"

    assert_text "Congratulations!"
  end
end
