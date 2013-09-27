require './test/integration_helper'

class BreakdownTest < Minitest::Test

  def alice
    @alice ||= User.create(username: 'alice')
  end

  def test_simple_breakdown
    skip "Breakdown needs a rethink"
    ruby_bob = create_sample_exercise('ruby', 'bob')
    ruby_word_count = create_sample_exercise('ruby', 'word-count')
    ruby_whatever = create_sample_exercise('ruby', 'whatever')
    python_bob = create_sample_exercise('python', 'bob')
    python_word_count = create_sample_exercise('python', 'word-count')

    bob = ruby_bob.exercise_type
    word_count = ruby_word_count.exercise_type
    whatever = ruby_whatever.exercise_type

    Submission.create(user: alice, exercise: ruby_bob)
    Submission.create(user: alice, exercise: ruby_bob)
    Submission.create(user: alice, exercise: ruby_word_count)
    Submission.create(user: alice, exercise: python_bob)
    Submission.create(user: alice, exercise: python_word_count)

    breakdown = Breakdown.of(ruby)
    assert_equal 2, breakdown[bob]
    assert_equal 1, breakdown[word_count]
    assert_equal 0, breakdown[whatever]
  end

end
