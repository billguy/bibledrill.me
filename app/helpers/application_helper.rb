module ApplicationHelper

  def asset_exists?(asset_name)
    if Rails.application.assets
      Rails.application.assets.find_asset(asset_name)
    else
      Rails.application.assets_manifest.assets[asset_name]
    end
  end

  def default_meta_tags
    {
      site: 'BibleDrill.me',
      reverse: true
    }
  end

end