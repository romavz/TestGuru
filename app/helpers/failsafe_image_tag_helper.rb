module FailsafeImageTagHelper
  DEFAULT_IMAGE_PATH = 'image_not_found.png'.freeze

  def failsafe_image_tag(source, options = {})
    source = DEFAULT_IMAGE_PATH unless Validators::ImageExistenceValidator.valid?(source)
    image_tag(source, options)
  end
end
