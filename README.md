rvpacker
======================

A tool to unpack & pack rvdata2 files into text so they can be version controlled & collaborated on

Credit to SiCrane
=================

These are copied/lifted/modified from SiCrane's original YAML importer/exporter on the gamedev forums. I initially just put them in github so I wouldn't lose them, and added the rvpacker script frontend.

http://www.gamedev.net/topic/646333-rpg-maker-vx-ace-data-conversion-utility/

Usage
=====

This is a command line utility written in ruby; it should run anywhere with Ruby 1.9 or higher with psych 2.0.0 and trollop gems.

    $ ./rvpacker.rb --help
    Options:
	    --action, -a <s>:   Action to perform on project (unpack|pack)
	   --project, -d <s>:   RPG Maker Project directory
		 --force, -f:   Update target even when source is older than target
      --project-type, -t <s>:   Project type (vx|ace|xp)
		  --help, -h:   Show this message

For example, to unpack a RPG Maker VX Ace project in ~/Documents/RPGVXAce/Project1:

    rvpacker.rb --action unpack --project ~/Documents/RPGVXAce/Project1 --project-type ace

... This will expand all Data/*rvdata2 files into (PROJECT)/YAML/ as YAML files (YAML is used because the object serialization data is retained, which ruby's YAML parser is very good at - otherwise I would have changed it to JSON). The Scripts will be unpacked as individual .rb files into (PROJECT)/Scripts/.

To take a previously unpacked project, and pack it back up:

    rvpacker.rb --action pack --project ~/Documents/RPGVXAce/Project1 --project-type ace

... This will take all of the yaml files in (PROJECT)/YAML and all the scripts in (PROJECT)/Scripts, and repack all of your (PROJECT)/*rvdata2 files. You can trust this to completely reassemble your Data/ directory, so long as the Scripts/ and YAML/ directories remain intact.

Workflow
========

This is great for teams that are collaborating on an RPG Maker project. Just add a few steps to your existing workflow:

* Checkout the project from version control
* Run 'rvpacker.rb --action pack' on the project to repack it for the RPG Maker tool
* Load up RPG Maker and do whatever you're going to do; save the project
* Run 'rvpacker.rb --action unpack' on the project
* Commit everything to version control (ignore the Data directory since you don't need it anymore; use .gitignore or .hgignore or whatever)

... Now your project can be forked/merged in a much more safe/sane way, and you don't have to have someone bottlenecking the entire process.

Psych 2.0.0 Dependency
======================

From SiCrane:

I used cygwin's ruby 1.9.3 and the Psych 2.0.0 ruby gem, which appears to be the most recent version. However, Psych 2.0.0 has some bugs that impacted the generated YAML (one major and one minor) which I monkey patched, and since I was already rewriting the Psych code, I added some functionality to make the generated YAML prettier. Long story short, this code probably won't work with any version of Psych but 2.0.0.