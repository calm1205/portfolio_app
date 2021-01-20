require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  username: "root",
  password: "",
  database: "portfolio_app_development",
)

namespace :delete_table_data do
  table_names = ActiveRecord::Base.connection.tables
  desc 'rails delete_table_data:<table_name>'

  table_names.each do |table_name|
    task "#{table_name}": :environment do
      class_name = table_name.camelize.sub(/s$/, '')
      Object.const_get(class_name).delete_all
    end
  end
end