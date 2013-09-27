class Trail

  attr_reader :language, :path, :slugs
  def initialize(language, slugs, path)
    @slugs = slugs
    @language = language
    @path = path
  end

  def find(slug)
    exercises.find {|ex| ex.slug == slug}
  end

  def assign(slug)
    Assignment.new(language, slug, path)
  end

  def first
    exercises.first
  end

  def first_assignment
    assign(first.slug)
  end

  def after(exercise, completed = [])
    exercises.find do |ex|
      !completed.include?(ex.slug)
    end
  end

  private

  def exercises
    @exercises ||= Exercise.where(language_id: language.id).
                            where(exercise_type_id: exercise_types)
  end

  def exercise_types
    @exercise_types ||= ExerciseType.where(slug: @slugs).pluck(:id)
  end

end
