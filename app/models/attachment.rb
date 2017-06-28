class Attachment < ApplicationRecord
  validates :mime, format: {
    with: /\A[\w\-]+\/[\w\-]+\z/,
    message: '不正なMIME形式です'
  }, allow_blank: true

  validates :data_file, presence: true

  attr_reader :data_file
  def data_file=(file)
    if @data_file = file
      self.name = file.original_filename(/[^\w!\#$%&()=^~|@`\[\]\{\};+,.-]/u, '')
      self.mime = file.content_type.gsub(/[^\w.+;=_\/-]/n, '')
      self.data = file.read
    else
      self.data = nil
    end
  end

  def is?(type)
    self.mime =~ /^#{type}\//i
  end
end
