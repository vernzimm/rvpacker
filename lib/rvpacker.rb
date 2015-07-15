# Automatically require all `rvpacker` Ruby files in 'lib'.
Dir[File.expand_path('../**/*.rb', __FILE__)].sort.each(&method(:require))

module Rvpacker
  def self.project_type_for(directory)
    case Dir["#{File.expand_path(directory)}/Game.r?proj*"][0]
    when /Game\.rxproj$/  then :xp
    when /Game\.rvproj$/  then :vx
    when /Game\.rvproj2$/ then :ace
    end
  end

  def self.valid_project?(directory)
    file = Dir["#{File.expand_path(directory)}/Game.r?proj*"][0]
    !!(file =~ /Game\.r(?:xproj|vproj2?)$/)
  end
end
