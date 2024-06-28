# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# /app/assets
Rails.application.config.assets.precompile += %w( admins_backoffice.js admins_backoffice.css users_backoffice.js users_backoffice.css admin_devise.js admin_devise.css user_devise.js user_devise.css site.js site.css)

# /lib/assets
Rails.application.config.assets.precompile += %w( sb-admin-2.js sb-admin-2.min.js sb-admin-2.css sb-admin-2.min.css custom.js custom.min.js custom.css custom.min.css img.jpg color-modes.js bootstrap.min.css navbar-fixed.css )

# /vendor/javascript
Rails.application.config.assets.precompile += %w( jquery-2.2.4/dist/jquery.js )
