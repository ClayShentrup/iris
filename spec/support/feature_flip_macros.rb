# Module to eaisly enable/disable features in tests
module FeatureFlipMacros
  def enable_feature(feature_key)
    Feature.find_or_initialize_by(key: feature_key.to_s)
      .update_attributes(enabled: true)
  end

  def disable_feature(feature_key)
    Feature.find_or_initialize_by(key: feature_key.to_s)
      .update_attributes(enabled: false)
  end
end
