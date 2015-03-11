# Create an array of the bundle IDs that have been purchased
module AccessibleBundleIds
  def self.call(user)
    user.account_bundles.map(&:bundle_id)
  end
end
