require 'rvpacker/rgss'
require 'rvpacker/rgss/basic_coder'
require 'rvpacker/rgss/psych_mods'
require 'rvpacker/rgss/serialize'
require 'rvpacker/rpg'
require 'rvpacker/version'

module Rvpacker
  def self.project_type_for(dir)
    case File.basename(Dir["#{File.expand_path(dir)}/Game.r?proj*"][0] || '.')
    when 'Game.rxproj'  then 'xp'
    when 'Game.rvproj'  then 'vx'
    when 'Game.rvproj2' then 'ace'
    else
      'ace'
    end
  end
  
  def self.valid_project?(dir)
    !Dir["#{File.expand_path(dir)}/Game.r?proj*"].empty?
  end
end
