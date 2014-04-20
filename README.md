rvpacker
======================

A tool to unpack & pack rvdata2 files into text so they can be version controlled & collaborated on

rvpacker consists of 3 parts:

* RPG library (stub classes for serialization of RPGMaker game data)
* RGSS library (some more classes for RPGMaker serialization)
* rvpacker (the script you call on the frontend)

Credit to SiCrane
=================

The RPG and RGSS libraries were originally taken from SiCrane's YAML importer/exporter on the gamedev forums. I initially just put them in github so I wouldn't lose them, and added the rvpacker script frontend. They are starting to drift a bit, but SiCrane still gets original credit for the grand majority of the work that rvpacker does.

http://www.gamedev.net/topic/646333-rpg-maker-vx-ace-data-conversion-utility/

Installation
============

rvpacker is bundled as a rubygem

    []$ gem install rvpacker

... dependencies will be handled automatically.

Usage
=====

    $ rvpacker --help
    Options:
	    --action, -a <s>:   Action to perform on project (unpack|pack)
	   --project, -d <s>:   RPG Maker Project directory
		 --force, -f:   Update target even when source is older than target
      --project-type, -t <s>:   Project type (vx|ace|xp)
		  --help, -h:   Show this message

For example, to unpack a RPG Maker VX Ace project in ~/Documents/RPGVXAce/Project1:

    rvpacker --action unpack --project ~/Documents/RPGVXAce/Project1 --project-type ace

... This will expand all Data/* files into (PROJECT)/YAML/ as YAML files (YAML is used because the object serialization data is retained, which ruby's YAML parser is very good at - otherwise I would have changed it to JSON). The Scripts will be unpacked as individual .rb files into (PROJECT)/Scripts/.

To take a previously unpacked project, and pack it back up:

    rvpacker --action pack --project ~/Documents/RPGVXAce/Project1 --project-type ace

... This will take all of the yaml files in (PROJECT)/YAML and all the scripts in (PROJECT)/Scripts, and repack all of your (PROJECT)/Data/* files. You can trust this to completely reassemble your Data/ directory, so long as the Scripts/ and YAML/ directories remain intact.

Workflow
========

This is great for teams that are collaborating on an RPG Maker project. Just add a few steps to your existing workflow:

* Checkout the project from version control
* Run 'rvpacker --action pack' on the project to repack it for the RPG Maker tool
* Load up RPG Maker and do whatever you're going to do; save the project
* Run 'rvpacker --action unpack' on the project
* Commit everything to version control (ignore the Data directory since you don't need it anymore; use .gitignore or .hgignore or whatever)

... Now your project can be forked/merged in a much more safe/sane way, and you don't have to have someone bottlenecking the entire process.

Automatic ID generation
=======================

You can add new elements to the YAML files manually, and leave their 'id:' field set to 'null'. This will cause the rvpacker pack action to automatically assign them a new ID number at the end of the sequence (e.g., if you have 17 items, the new one becomes ID 18). This is mainly handy for adding new scripts to the project without having to open the RPG maker and paste the script in; just make the new script file, add its entry in YAML/Scripts.yaml, and the designer will have your script accessible the next time they repack and open the project.

Also, the rvpacker tool sets the ID of script files to an autoincrementing integer. The scripts exist in the database with a magic number that I can't recreate, and nothing in the editor (RPG VX Ace anyway) seems to care if the magic number changes. It doesn't even affect the ordering. So in order to support adding new scripts with null IDs, like everything else, the magic numbers on scripts are disregarded and a new ID number is forced on the scripts when the rvpacker pack action occurs.

Psych 2.0.0 Dependency
======================

From SiCrane:

I used cygwin's ruby 1.9.3 and the Psych 2.0.0 ruby gem, which appears to be the most recent version. However, Psych 2.0.0 has some bugs that impacted the generated YAML (one major and one minor) which I monkey patched, and since I was already rewriting the Psych code, I added some functionality to make the generated YAML prettier. Long story short, this code probably won't work with any version of Psych but 2.0.0.