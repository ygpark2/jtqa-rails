Rails.application.config.paths.add "app/api", glob: "**/*.rb"
Rails.application.config.autoload_paths += Dir["#{Rails.root}/app/api/*"]
