# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( drills.js drills.css unlocks.css confirmations.css passwords.css registrations.css registrations.js sessions.css loader.css jquery.timer.js nouislider.css nouislider.js wow_book/* jquery.js jquery_ujs.js wow_book.js wow_book.css bible.js site.js site.css books.js chapters.js verses.js books.css chapters.css verses.css )
