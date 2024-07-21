require("lua.how")
-- Add LuaRocks paths
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.luarocks/share/lua/5.4/?.lua'
package.cpath = package.cpath .. ';' .. os.getenv("HOME") .. '/.luarocks/lib/lua/5.4/?.so'

