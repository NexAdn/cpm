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
    sVersion = "0.1",
    
    sPackagesFile       = "/packages",
    sDependenciesFile   = "/dependencies",
    sVersionFile        = "/version",
    sMainLua            = "/main.lua"
}

local tMsg = {
	usageMessage = "Syntax: cpm install [package]\n        cpm update\n        cpm cpmupdate",
    wrongURL = "Wrong URL",
    generalError = "Unkown error occured!",
    updateSuccess = "Successfully updated CPM"
}

local tData = {
    aPackageList = {},
    aVersionList = {}
}

local tArgs = { ... }

function fetchArgs()
    if tArgs[1] == "update" then
           tData.aPackageList,tData.aVersionList = cpmUpdate()
    elseif tArgs[1] == "install" then
        if #tArgs < 2 then
            print(tMsg.usageMessage)
        end
        if cpmInstall(tArgs[2]) ~= 1 then
            print(tMsg.generalError) 
        end
    elseif tArgs[1] == "upgrade" then
        cpmUpgrade()
    elseif tArgs[1] == "cpmupdate" then
        local res = downloadFile("https://raw.githubusercontent.com/NexAdn/cpm/master/cpm.lua")
        if res == nil then
            print(tMsg.generalError)
        else
            local buf = nil
            local file = fs.open("cpm", "w")
            while true do
                buf = res.readLine()
                if buf == nil then
                    break
                end
                fs.writeLine(buf)
            end
            print(tMsg.updateSuccess)
        end
    else
        print(tMsg.usageMessage)
    end
end

function checkURL(sURL)
    if http.checkURL(sURL) == false then
        print(tMsg.wrongURL)
        return false
    end
    return true
end

function cpmUpdate()
    local sListURL = tConfig.aPackageServer .. tConfig.sPackageDirectory .. tStatic.sPackagesFile
    if checkURL(sListURL) then
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
            local tVersionList = {}
            for k,v in pairs(tFileList) do
                local res = http.get(tConfig.aPackageServer .. tConfig.sPackageDirectory .. "/" .. v .. tStatic.sVersionFile)
                if res.getResponseCode() ~= 200 then
                    print(tMsg.generalError)
                    return nil,nil
                end
                tVersionList[k] = res.readLine()
            end
            return tFileList,tVersionList
        else
            print(tMsg.generalError)
        end
    end
end

function cpmUpgrade()
    return 0
end

function cpmInstall(sPackage)
    -- Recursive dependency installation
    loadDependencies(sPackage)
    
    local res = downloadFile(tConfig.aPackageServer .. tConfig.sPackageDirectory .. "/" .. sPackage .. tStatic.sMainLua)
    
    if res == nil then
        print(tMsg.generalError)
        return -1
    end
    
    local file = fs.open(sPackage, "w")
    
    local buf = nil
    
    while true do
        buf = res.readLine()
        if buf ~= nil then
            file.writeLine(buf)
        else
            break
        end
    end
    
    file.close()
    
    return 1
end

function downloadFile(sURL)
    if checkURL(sURL) then
        local res = http.get(sURL)
        
        if res.getResponseCode() ~= 200 then
            return nil
        end
        
        return res
    else
        return nil
    end
end

function loadDependencies(sPackage)
    local res = downloadFile( tConfig.aPackageServer .. tConfig.sPackageDirectory .. "/" .. sPackage .. tStatic.sDependenciesFile )
    
    local buf = nil
    
    while true do
        buf = res.readLine()
        
        if buf == nil or buf == "NULL" then
            break
        end
        
        cpmInstall(buf)
    end
end

function main()
    textutils.slowPrint("CPM " .. tStatic.sVersion)
    --[[for k,v in pairs(tArgs) do
        print(k .. " " ..v)
    end]]
    fetchArgs()
end

main()
