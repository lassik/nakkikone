Rails.application.config.requirejs.logical_asset_filter += [/\.hbs$/]
#Rails.application.config.requirejs.logical_path_patterns += [/\.hbs$/] waits for requirejs-rails 1.x upgrade
Rails.application.config.assets.precompile += %w( _bootstrap.min.css bootstrap-responsive.min.css datepicker.css bootstrap-wysihtml5.css bootstrap-timepicker.css print.css style.css )

