# Automatically require all `rvpacker` Ruby files in 'lib'.
Dir[File.expand_path('../**/*.rb', __FILE__)].each(&method(:require))

# `rvpacker` packs and unpacks binary RPG Maker project data to and from YAML
# so that it can be version-controlled and collaborated on.
module Rvpacker
end
