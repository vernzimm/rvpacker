# Automatically require all `rvpacker` Ruby files in 'lib'.
Dir[File.expand_path('../**/*.rb', __FILE__)].sort.each(&method(:require))

# `rvpacker` packs and unpacks binary RPG Maker project data to and from YAML
# so that it can be version-controlled and collaborated on.
module Rvpacker
  # @param directory [String] the directory to obtain the project type for
  # @return [:xp, :vx, :ace, nil] the project type of the given directory if it
  #   could be determined, `nil` otherwise
  def self.project_type_for(directory)
    case Dir["#{File.expand_path(directory)}/Game.r?proj*"][0]
    when /Game\.rxproj$/  then :xp
    when /Game\.rvproj$/  then :vx
    when /Game\.rvproj2$/ then :ace
    end
  end

  # @param directory [String] the directory to test the validity of
  # @return [Boolean] `true` if the directory is the root of a valid RPG Maker
  #   project, `false` otherwise
  def self.valid_project?(directory)
    file = Dir["#{File.expand_path(directory)}/Game.r?proj*"][0]
    file =~ /Game\.r(?:xproj|vproj2?)$/ ? true : false
  end
end
