require File.expand_path(File.dirname(__FILE__) + "/lib/generator_commands.rb")
 
class RpxAuthenticatedGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'create_auth_tables.rb', 'db/migrate', :migration_file_name=>'create_auth_tables'
      m.file 'user.rb', 'app/models/user.rb'
      m.file 'sessions_controller.rb', 'app/controllers/sessions_controller.rb'
      m.file 'rpx_authentication.rb', 'config/initializers/rpx_authentication.rb'
 
      m.directory 'app/views/sessions'
      m.file 'new.html.erb', 'app/views/sessions/new.html.erb'
 
      m.add_routes :session, 'routes.rb'
      m.config_gem 'httparty'
    end
  end
end