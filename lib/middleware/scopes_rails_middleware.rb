class ScopesRailsMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    Dir.glob('app/scopes/**/*').each do |scopes|
      next unless scopes.include? '.rb'
      file_name = scopes.gsub('app/scopes/', '')
      class_name = file_name[0, file_name.rindex('_')].camelize
      scopes_module_name = "#{class_name}Scopes".constantize
      class_name.constantize.class_eval do
	include scopes_module_name
      end
    end
    @app.call env
  end
end
