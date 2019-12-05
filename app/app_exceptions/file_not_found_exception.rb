module AppExceptions
  class FileNotFoundException < AppExceptions::BaseException
    def initialize(file_path)
      message = I18n.t('exceptions.file_not_found')
      message = "#{message}: '#{file_path}'"
      super(message)
    end
  end
end
