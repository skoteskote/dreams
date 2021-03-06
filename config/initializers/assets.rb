# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif]
Rails.application.config.assets.precompile += %w( blueimp_script.js loomio-embed.min.js loomio )
Rails.application.config.assets.precompile += %w( multiprogress.js )
Rails.application.config.assets.precompile += %w( spectrum.js )
Rails.application.config.assets.precompile += %w( jquery.autogrowtextarea.js )
Rails.application.config.assets.precompile += %w( spectrum.css )
