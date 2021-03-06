# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( spin.js jquery.spin.js summernote-ext-video.js images/* Sortable.js bible_search.js studies.js studies_form.js studies.css jquery.infinitescroll.js highlight.js highlight.css dragula.css dragula.js jquery.clearsearch.js contacts.js contacts.css mailer.js mailer.css drills.js drills.css unlocks.css confirmations.css passwords.css registrations.css registrations.js sessions.css loader.css jquery.timer.js nouislider.css nouislider.js wow_book/* jquery.js jquery_ujs.js wow_book.js wow_book.css bible.js site.js site.css books.js chapters.js verses.js books.css chapters.css verses.css )
