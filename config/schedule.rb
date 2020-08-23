
# Rails.rootを使用するために必要。なぜなら、wheneverは読み込まれるときにrailsを起動する必要がある
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
ENV.each { |k, v| env(k, v) } # 環境変数をcrontabにセット

# cronのログの吐き出し場所。ここでエラー内容を確認する
set :output, "#{Rails.root}/log/cron.log"


# subsucription 定期支払い
every 1.month, at: 'start of the month at 0am' do
  rake "subscription:subscription_task"
  command "echo 'this environment is #{ENV['RAILS_ENV']}!'"
  command "echo 'subscription settlement is done.'"
end