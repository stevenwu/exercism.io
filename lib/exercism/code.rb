class Code

  attr_reader :path
  def initialize(path)
    @path = path
  end

  def language
    @language ||= begin
      find_language || raise(Exercism::UnknownLanguage.new)
    end
  end

  def filename
    @filename ||= path_segments.last
  end

  def extension
    @extension ||= filename[/([^\.]+)\Z/, 1]
  end

  def slug
    path_segments[-2]
  end

  private

  def path_segments
    @path_segments = path.split(/\/|\\/)
  end

  def find_language
    Language.where(code_extension: extension).first
  end
end

