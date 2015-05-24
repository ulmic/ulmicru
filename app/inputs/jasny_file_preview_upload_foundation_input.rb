class JasnyFilePreviewUploadFoundationInput < JasnyFilePreviewUploadInput
  def initialize(*args)
    @button ||= 'button'
    @default_button ||= ''
    super *args
  end
end
