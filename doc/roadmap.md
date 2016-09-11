The roadmap is only updated in the development branch.

# 0.6
* store package and dependency information in .cpm.d/install.d/PACKAGENAME/
* add *cpm autoremove* to uninstall automaticially install dependencies that are not needed any longer

# 0.5
* split cpm script to multiple apis and files
* installer script for cpm

# 0.4
* support for package configuration subdirs
* cpm configuration in .cpm.d/

# 0.3
* data directory at .cpm.d/install.d containing a list of installed packages and installed package versions
* data files in .cpm.d/ containing the repository's package and version lists
* version checking
* manual updating of package lists
* keep versions of installed package versions in .cpm.d/install.d/PACKAGENAME
* prevent multiple installations of the same package (Already up-to-date)

# 0.2.1
* console output

# 0.2
* dependency checking and automatic downloads
* CPM updater from hardcoded URL (https://raw.githubusercontent.com/NexAdn/cpm/master/cpm.lua)

# 0.1
* simple download handler