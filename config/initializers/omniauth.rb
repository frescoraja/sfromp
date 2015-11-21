ENV['TWITTER_KEY'] ||= 'qYAKym6Oz4qo4hBs6IpWcFFbe'
ENV['TWITTER_SECRET'] ||= 'RJknDKC4Tf2mneuXiVNOjItp0lwhQmQaYePZPBgWIxvN47t3Ua'
ENV['FACEBOOK_APP_ID'] ||= '175366882811730'
ENV['FACEBOOK_SECRET'] ||= '6947d724e55618695279d03be61997a7'
ENV['GOOGLE_CLIENT_ID'] ||= '356586144854-5evtm8vm1ckvi2dtpsfm4q4eagp9vtmo.apps.googleusercontent.com'
ENV['GOOGLE_SECRET'] ||= 'CdObb16ug_vhazQzf4ZpWh9D'
ENV['LINKEDIN_KEY'] ||= '75zfo02qxo2phf'
ENV['LINKEDIN_SECRET'] ||= '74tpnwj3Ya31QuWb'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], secure_image_url: true

  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
  scope: 'public_profile', info_fields: 'id,name,link', secure_image_url: true

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'],
  scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'

  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
  scope: 'r_basicprofile',
  fields: ['id', 'first-name', 'last-name', 'location', 'picture_url', 'public_profile-url']
end

OmniAuth.config.on_failure = Proc.new do |env|
  SessionsController.action(:auth_failure).call(env)
end
