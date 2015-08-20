class ApplicationUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "system/uploads/#{model_class}/#{mounted_as}/#{model.id}"
  end

  private

  def model_class
    model.class.model_name == 'Questionary' ? :member : model.class.model_name.to_s.underscore
  end
end
