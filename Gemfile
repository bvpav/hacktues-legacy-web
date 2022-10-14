source 'https://rubygems.org'

gem 'rails',                   '4.2.2'
gem 'bcrypt',                  '3.1.7'
gem 'faker',                   '1.4.2'
gem 'friendly_id',             '5.1.0'
gem 'babosa',                  '0.3.11'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'sass-rails',              '5.0.2'
gem 'bootstrap-sass',          '3.2.0.4'
gem 'uglifier',                '2.5.3'
gem 'coffee-rails',            '4.1.0'
gem 'jquery-rails',            '4.0.3'
gem 'turbolinks',              '2.3.0'
gem 'jbuilder',                '2.2.3'
gem 'ckeditor',                '4.1.3'
gem 'paperclip',               '5.0.0'
gem 'barby',                   '0.6.1'
gem 'rqrcode',                 '0.7.0'
gem 'chunky_png',              '1.3.4'
gem 'rack-cors', :require => 'rack/cors'
gem 'sdoc',                    '0.4.0', group: :doc

# `bundle` инсталира прекалено нови версии на тези, така че ги pin-ваме за стената:
gem 'racc',                    '~> 1.4.12'
gem 'nokogiri',                '~> 1.6.6.2'
gem 'ffi',                     '~> 1.9.5'
gem 'listen',                  '~> 3.0.3'
gem 'lumberjack',              '~> 1.0.9'
gem 'mimemagic',               '~> 0.3.7', '< 0.3.10'
# (и `minitest`, ама то е в :test)

group :development, :test do
  gem 'sqlite3',     '1.3.9'
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'

  # pin за съвместимост с Ruby 2.2.2
  gem 'minitest',           '~> 5.7.0'
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'puma',           '2.11.1'
end
