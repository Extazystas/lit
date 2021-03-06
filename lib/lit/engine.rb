module Lit
  class Engine < ::Rails::Engine
    config.autoload_paths += %W[#{Lit::Engine.root}/app/controllers/lit/concerns]

    isolate_namespace Lit

    initializer 'lit.assets.precompile' do |app|
      app.config.assets.precompile += %w[lit/application.css lit/application.js]
      app.config.assets.precompile += %w[lit/lit_frontend.css lit/lit_frontend.js]
    end

    initializer 'lit.migrations.append' do |app|
      unless app.root.to_s.include?(root.to_s)
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
