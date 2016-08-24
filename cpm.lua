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
	aPackageServer = "https://raw.githubusercontent.com",
	-- Path to main repository directory
	sPackageDirectory = "/nexadn/cpmcontent/master"
}

-- Static configuration (DO NOT CHANGE)
local tStatic = {
	sVersion = "0.0.1",
    
    sPackagesFile       = "/packages",
    sDependenciesFile   = "/dependencies",
    sVersionFile        = "/version",
    sMainLua            = "/main.lua"
}

local tMsg = {
	usageMessage = "Syntax: cpm install [package]\n        cpm update",
    wrongURL = "Wrong URL",
    generalError = "Unkown error occured!"
}

local tData = {
	
}

local tArgs = { ... }

function fetchArgs()
	if #tArgs <2 then
		textutils.slowPrint(tMsg.usageMessage);
	else
        if tArgs[1] == "update" then
            cpmUpdate()
        elseif tArgs[1] == "install" then
            cpmInstall()
        end
	end
end

function checkURL(sURL)
    if http.checkURL() == false then
        print(tMsg.wrongURL)
        exit 1
    end
    return true
end

function cpmUpdate()
    local sListURL = tConfig.aPackageServer .. tConfig.sPackageDirectory .. tStatic.sPackagesFile
    if checkUrl() then
        local tResPkglist = http.get(sListURL)
        if tResPkglist.getResponseCode() == 200 then
            local tFileList = {}
            local i = 0
            local cont = true
            while cont do
                i = i + 1
                tFileList[i] = tResPkglist.readLine()
                if tFileList[i] == nil then
                    cont = false
                end
            end
        else
            print(tMsg.generalError)
        end
    end
end

function cpmInstall()
    
end
