package = "kong-plugin-consumer-interval"  


local pluginName = package:match("^kong%-plugin%-(.+)$")  -- "consumer-interval"

supported_platforms = {"linux", "macosx"}
version = "0.1"
source = {
  -- these are initially not required to make it work
  url = "git://github.com/diacdg/kong-consumer-interval.git"
}

description = {
  summary = "consumer-interval",
  homepage = "http://getkong.org",
  license = "MIT"
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins."..pluginName..".handler"] = "kong/plugins/"..pluginName.."/handler.lua",
    ["kong.plugins."..pluginName..".schema"] = "kong/plugins/"..pluginName.."/schema.lua",
  }
}
