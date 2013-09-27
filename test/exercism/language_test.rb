require './test/test_helper'
require 'exercism/exercise'

class LanguageTest < Minitest::Test
  def test_display_name_capitalization
    name = "foobar"
    language = Language.create!(name: name, code_extension: "x", test_extension: "x")
    assert_equal "Foobar", language.display_name
  end

  def test_display_name_splitting
    name = "foo-bar"
    language = Language.create!(name: name, code_extension: "x", test_extension: "x")
    assert_equal "Foo Bar", language.display_name
  end

  def test_to_s
    name = "foobar"
    language = Language.create(name: name)
    assert_equal language.name, language.to_s
  end

  def test_to_sym
    language = Language.create(name: "foobar")
    assert_equal :foobar, language.to_sym
  end
end
