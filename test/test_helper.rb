$:.unshift File.expand_path("../../lib", __FILE__)

ENV['RACK_ENV'] = 'test'
require 'simplecov' if ENV['COVERAGE']

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'active_record_helper'

class Minitest::Test
  def create_sample_exercise(language_name='ruby', slug='word-count')
    language = Language.where(name: language_name).first ||
               Language.create(name: language_name,
                               code_extension: language_name[0..1],
                               test_extension: language_name[0..1])

    type = ExerciseType.find_or_create_by_slug(slug)
    Exercise.create!(language: language, exercise_type: type)
  end
end

module Minitest::Alice

  #def current
  #  {'ruby' => 'button', 'python' => 'eggs', 'go' => 'light'}

  #def completed
  #  {'ruby' => ['hypothesis', 'tree'], 'python' => ['gyroscope']}

  { go: "go",
    haskell: "hk",
    ruby: "rb",
    python: "py",
    clojure: 'cl'
  }.each do |lang, ext|
    define_method lang do
      unless instance_variable_get "@#{lang}"
        instance_variable_set "@#{lang}", Language.create(name: lang.to_s,
                                                          code_extension: ext,
                                                          test_extension: ext)
      end
      instance_variable_get "@#{lang}"
    end
  end

  def hypothesis
    @hypothesis ||= ExerciseType.create!(slug: 'hypothesis')
  end

  def ruby_button
    @ruby_button ||= Exercise.create!(language: ruby, exercise_type: ExerciseType.create(slug: 'button'))
  end

  def ruby_hypothesis
    @ruby_hypothesis ||= Exercise.create!(language: ruby, exercise_type: hypothesis)
  end

  def ruby_pill
    @ruby_pill ||= Exercise.create!(language: ruby, exercise_type: ExerciseType.create(slug: 'pill'))
  end

  def python_tissue
    @python_tissue ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'tissue'))
  end

  def python_eggs
    @python_eggs ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'eggs'))
  end

  def python_gyroscope
    @python_gyroscope ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'gyroscope'))
  end

  def ruby_tree
    @ruby_tree ||= Exercise.create!(language: ruby, exercise_type: ExerciseType.create(slug: 'tree'))
  end

  def go_light
    @go_light ||= Exercise.create!(language: go, exercise_type: ExerciseType.create(slug: 'light'))
  end

  def python_gyroscope
    @python_gyroscope ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'gyroscope'))
  end

  def alice
    @alice ||= begin
      alice = User.create(username: 'alice')

      alice.user_exercises.create!(exercise: ruby_button, completed: false)
      alice.user_exercises.create!(exercise: python_eggs, completed: false)
      alice.user_exercises.create!(exercise: go_light, completed: false)

      alice.user_exercises.create!(exercise: ruby_hypothesis, completed: true)
      alice.user_exercises.create!(exercise: ruby_tree, completed: true)
      alice.user_exercises.create!(exercise: python_gyroscope, completed: true)
      alice
    end
  end
end
