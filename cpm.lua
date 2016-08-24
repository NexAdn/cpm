-- Copyright (C) 2016 Adrian Schollmeyer

-- cpm.lua is part of CPM.
--
--  CPM is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License and the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--  Licenses can be found in the COPYING-Folder.

-- User specific configuration
local tConfig = {
	-- Server URL to connect to
	aPackageServer = "rawgithub.com",
	-- Path to main repository directory
	sPackageDirectory = "/nexadn/cpmcontent"
}

-- Static configuration (DO NOT CHANGE)
local tStatic = {
	sVersion = "0.0.1"
}

local tMsg = {
	usageMessage = "Syntax: cpm install [package]\n        cpm update";
}

local tData = {
	
}

local tArgs = { ... }

function fetchArgs()
	if #tArgs != 3 then
		textutils.slowPrint(
	else

	end
end



