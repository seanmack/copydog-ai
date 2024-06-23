OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")

  if Rails.env.development?
    config.log_errors = true
  end
end
