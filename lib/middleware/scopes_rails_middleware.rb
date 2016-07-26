class ScopesRailsMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    ScopesRailsIncluding.initialize_scopes
    @app.call env
  end
end
