class Language < ActiveRecord::Base
  validates :name, presence: true
  validates :code_extension, presence: true
  validates :test_extension, presence: true

  before_save do
    set_display_name_from_name
  end

  def to_s
    name
  end

  def to_sym
    name.to_sym
  end

  private

  def set_display_name_from_name
    self.display_name = name.split('-').map(&:capitalize).join(' ')
  end
end
