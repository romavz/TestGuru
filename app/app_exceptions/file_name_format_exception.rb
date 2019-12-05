module AppExceptions
  class FileNameFormatException < AppExceptions::BaseException
    def initialize(file_name_format)
      message = I18n.t('exceptions.wrong_image_name_format')
      message = "#{message} #{file_name_format}"
      super(message)
    end
  end
end
