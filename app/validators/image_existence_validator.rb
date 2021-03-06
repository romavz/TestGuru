module Validators
  class ImageExistenceValidator < Validators::BaseValidator
    WEB_RESOURCE = %r{^(https?:\/\/.*)$}i.freeze
    LOCAL_FILE   = %r{^(\w+\/)*\w+(\.(png|jpg|jpeg|gif))$}i.freeze
    IMAGES_DIR   = Rails.root.join('app', 'assets', 'images').freeze
    HTTP_STATUS_CODES = Rack::Utils::SYMBOL_TO_STATUS_CODE

    attr_reader :path_to_file

    def validate!(path_to_file)
      @path_to_file = path_to_file
      raise AppExceptions::FileNotFoundException, path_to_file unless file_exist?
    end

    def file_exist?
      case path_to_file
      when WEB_RESOURCE
        web_file_exist?
      when LOCAL_FILE
        local_file_exist?
      else
        false
      end
    end

    def web_file_exist?
      response = HTTParty.head(path_to_file)
      response.code == HTTP_STATUS_CODES[:ok]
    end

    def local_file_exist?
      File.exist?(File.join(IMAGES_DIR, path_to_file))
    end

  end
end
