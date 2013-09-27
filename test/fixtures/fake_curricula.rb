class FakeTrail
end

class FakePythonCurriculum < FakeTrail
  def slugs
    %w(one two)
  end

  def language
    Language.create(name: 'python', code_extension: 'py', test_extension: 'py')
  end
end

class FakeRubyCurriculum < FakeTrail
  def slugs
    %w(one two)
  end

  def language
    Language.create(name: 'ruby', code_extension: 'rb', test_extension: 'rb')
  end
end

class FakeGoCurriculum < FakeTrail
  def slugs
    %w(one two)
  end

  def language
    Language.create(name: 'go', code_extension: 'go', test_extension: 'go')
  end
end

class FakeCurriculum < FakeTrail
  def slugs
    %w(one two)
  end

  def language
    Language.create(name: 'fake', code_extension: 'ext', test_extension: 'test')
  end
end
