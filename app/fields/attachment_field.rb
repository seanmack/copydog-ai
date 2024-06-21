require "administrate/field/base"

class AttachmentField < Administrate::Field::Base
  def to_s
    data
  end
end
