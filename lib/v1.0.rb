require 'haml'
require 'exercism'

class Exercism
  module App
    def self.root
      'v1.0'
    end
  end
end

[
  'article_helper', 'fuzzy_time_helper',
  'markdown_helper', 'session_helper'
].each do |helper|
  require File.join(Exercism::App.root, 'helpers', helper)
end

[
  'site/carousel', 'user/navigation', 'user/account',
  'user/track', 'user/exercise', 'user/comment',
  'user/active_exercise', 'user/notification',
  'user/truncated_exercises', 'user/profile',
  'site/languages'
].each do |presenter|
  require File.join(Exercism::App.root, presenter)
end

['auth', 'alerts', 'site', 'help', 'exercises', 'solutions', 'teams', 'user'].each do |controller|
  require File.join(Exercism::App.root, controller)
end

class ExercismV1p0 < Sinatra::Base
  set :environment, ENV.fetch('RACK_ENV') { :development }.to_sym
  set :root, File.join('lib', Exercism::App.root)
  set :session_secret, ENV.fetch('SESSION_SECRET') { "Need to know only." }
  set :method_override, true

  enable :sessions

  helpers Sinatra::ArticleHelper
  helpers Sinatra::FuzzyTimeHelper
  helpers Sinatra::MarkdownHelper
  helpers Sinatra::SessionHelper

  helpers do
    def github_client_id
      ENV.fetch('EXERCISM_V1P0_GITHUB_CLIENT_ID')
    end

    def github_client_secret
      ENV.fetch('EXERCISM_V1P0_GITHUB_CLIENT_SECRET')
    end

    def site_root
      env.fetch('HTTP_HOST') { 'http://exercism.io' } << root_path
    end

    def root_path
      "/v1.0"
    end

    def link_to(path)
      File.join(root_path, path)
    end

    def nav
      @nav ||= App::User::Navigation.new(current_user)
    end
  end
end
