class CodeBlock < ActiveRecord::Base
  belongs_to :snippet
  validates_presence_of :title

  CODE_TYPES = %w(js html css ruby)

  def to_s
    title
  end

  # This method scans the code with coderay and outputs its div.
  def code_html
    CodeRay.scan(code, code_type.to_sym).div
  end

  def deleted?
    !!self.deleted_at
  end
end
