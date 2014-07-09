Rails.application.config.middleware.insert 0, Rack::Cors, :debug => true, :logger => Rails.logger do
  allow do
    origins '*'
    resource '/.well-known/host-meta'
    resource '/api/*',
             :headers => :any,
             :methods => [:get, :post, :delete, :put, :options],
             :max_age => 0
  end
end