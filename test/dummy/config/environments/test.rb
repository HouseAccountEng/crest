Rails.application.configure do
  config.enable_reloading = false
  # Never, unlike a host's own suite: this app has nothing to eager load, and the guard below
  # only watches a boot that does not.
  config.eager_load = false
  config.consider_all_requests_local = true
  # A load hook run before the app is up costs a host its boot time, and Rails only logs it.
  # Raising here is what makes the suite refuse the gem that causes one.
  config.action_on_early_load_hook = :raise
  config.active_support.deprecation = :stderr
  config.action_controller.allow_forgery_protection = false
end
