class Assignment

  attr_reader :path, :language, :slug, :data_dir
  def initialize(language, slug, path)
    @language = language
    @slug = slug
    @data_dir = path
    @path = File.join(path, language.to_s, slug)
  end

  def name
    exercise.exercise_type.name
  end

  def exercise
    @exercise ||= begin
      type = ExerciseType.where(slug: slug).first!
      Exercise.where(language_id: language.id, exercise_type_id: type.id).first!
    end
  end

  def tests
    @tests ||= read(test_file)
  end

  def test_file
    "#{slug}_test.#{language.test_extension}"
  end

  def example
    @example ||= read(example_file)
  end

  def example_file
    "example.#{language.code_extension}"
  end

  def blurb
    data['blurb']
  end

  def source
    data['source']
  end

  def source_url
    data['source_url']
  end

  def instructions
    @instructions ||= read_shared instructions_file
  end

  def readme
    @readme ||= <<-README
# #{name}

#{blurb}

#{instructions}

## Source

#{source} [view source](#{source_url})
README
  end

  private

  def data
    @data ||= YAML.load read_shared data_file
  end

  def data_file
    "#{slug}.yml"
  end

  def instructions_file
    "#{slug}.md"
  end

  def read(file)
    File.read path_to(file)
  end

  def path_to(file)
    File.join(path, file)
  end

  def read_shared(file)
    File.read path_to_shared(file)
  end

  def path_to_shared(file)
    File.join(data_dir, 'shared', file)
  end

end

