Crest.configure do |config|
  config.name = 'HouseAccount'
  config.org = 'HouseAccount'
  config.url = 'https://houseaccount.com/'
  config.email = 'hello@houseaccount.com'
  config.photo = Rails.root.join 'public/cube.png'
  # Read every time a card is drawn: the number differs between production and staging.
  config.phone = -> { ENV.fetch 'CREST_PHONE', '+18005550100' }
end
