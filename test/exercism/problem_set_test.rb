require './test/test_helper'
require 'exercism/exercise'
require 'exercism/problem_set'

class ProblemSetTest < Minitest::Test
  include Minitest::Alice

  #def current
  #  {'ruby' => 'button', 'python' => 'eggs', 'go' => 'light'}

  #def completed
  #  {'ruby' => ['hypothesis', 'tree'], 'python' => ['gyroscope']}

  def test_doing
    assert alice.doing?(ruby)
    assert alice.doing?(python)
    assert alice.doing?(go)
    refute alice.doing?(clojure)
  end

  def test_did
    assert alice.did?(ruby)
    assert alice.did?(python)
    refute alice.did?(go)
  end

  def test_current_exercises
    ruby, python, go = alice.current_exercises
    assert_equal ruby_button, ruby
    assert_equal python_eggs, python
    assert_equal go_light, go
  end

  def test_completed_exercises
    skip "Fix this"
    hypothesis, tree = alice.completed_exercises
    gyroscope = alice.completed_exercises['python'].first
    assert_equal ruby_hypothosis, hypothesis
    assert_equal ruby_tree, tree
    assert_equal python_gyroscope, gyroscope
  end

  def test_completed_p
    assert alice.completed?(ruby_hypothesis), 'hypothesis'
    assert alice.completed?(ruby_tree), 'tree'
    refute alice.completed?(ruby_button), 'button'
    refute alice.completed?(ruby_pill), 'pill'
  end

  def test_working_on_p
    assert alice.working_on?(ruby_button), 'button'
    refute alice.working_on?(ruby_hypothesis), 'hypothesis'
  end

  def test_current_languages
    assert_equal [go, python, ruby], alice.current_languages.sort
  end

  def test_current_exercise_in_language
    assert_equal ruby_button, alice.current_in(ruby)
  end

  def test_latest_in_language
    assert_equal python_gyroscope, alice.latest_in(python)
    assert_equal ruby_tree, alice.latest_in(ruby)
    assert_nil alice.latest_in(haskell)
  end
end

