require 'active_support/inflector'

class StyleGuide < Struct.new(:relative_path, :base_path)
  def self.all(base_path)
    Dir.glob(base_path.join('**/*/')).map do |path|
      new(File.basename(path), base_path)
    end
  end

  class Partial < Struct.new(:basename, :relative_path, :base_path)
    def name
      ActiveSupport::Inflector.titleize(basename)
    end

    def path
      base_path.join(relative_path, basename).to_s.gsub(base_path.dirname.to_s, '').gsub(/^\//, '')
    end
  end

  def name
    ActiveSupport::Inflector.titleize(relative_path)
  end

  def partials
    Dir.glob(base_path.join(relative_path).join('_*')).map do |path|
      Partial.new(File.basename(path).split('.').first.gsub(/^_/, ''), relative_path, base_path)
    end
  end
end
