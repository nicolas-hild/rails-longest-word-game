require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to the /new game page displays a random grid" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  # test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid" do
  #   visit new_url
  #   random_word = []
  #   random_word <<('a'..'z').to_a.sample unless random_word.length == 10
  #   fill_in "word", with: "#{random_word.join('')}"
  #   click_on "try"

  #   assert_text "sorry but '#{random_word.join('')}' don\'t use letters from the grid"
  # end
end
