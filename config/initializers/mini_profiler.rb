# Be sure to restart your server when you modify this file.

if defined? Rack::MiniProfiler
  # Result store (MemoryStore, RedisStore, MemcacheStore, and FileStore)
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore

  # Can either be 'right' or 'left'. Default is 'left'.
  Rack::MiniProfiler.config.position = 'right'

  # Whether or not you want the mini_profiler to be visible when loading a page
  # Rack::MiniProfiler.config.start_hidden = true

  # Ignore favicon.ico request
  Rack::MiniProfiler.config.skip_paths << '/favicon.ico'

  # Ignore Better Errors requests
  Rack::MiniProfiler.config.skip_paths << '/__better_errors/'
end
