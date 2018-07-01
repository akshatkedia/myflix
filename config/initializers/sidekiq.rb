Sidekiq::Extensions.enable_delay!

if Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end
