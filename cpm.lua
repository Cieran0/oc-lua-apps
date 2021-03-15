local fs = require("filesystem")
local baseurl = "https://raw.githubusercontent.com/Cieran0/oc-lua-apps/main/"
local ext = ".lua"
local listurl = "https://raw.githubusercontent.com/Cieran0/oc-lua-apps/main/list.txt"
os.execute("wget -q " .. listurl)
os.execute("cat list.txt")
os.execute("rm list.txt")
print("type name of package you wish to install")
s = io.read("*l")
if not fs.exists("/usr/bin") then 
    fs.makeDirectory("/usr/bin/")
end
os.execute("wget " .. baseurl .. s .. ext .. " /usr/bin/" .. s .. ext)