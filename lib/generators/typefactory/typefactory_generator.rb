require 'rails/generators/active_record'

class TypefactoryGenerator < ActiveRecord::Generators::Base

  def self.source_root
    @source_root = File.expand_path("../templates", __FILE__)
  end

  def config
    copy_file "initializer.rb", "config/initializers/typefactory.rb"
  end

end