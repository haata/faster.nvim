local features = require('faster.features')
local behaviours = require('faster.behaviours')

local M = {}

local default_config = {
  features = features,
  behaviours = behaviours,
}

Config = {}

function M.setup(opts)
  Config = vim.tbl_deep_extend("force", default_config, opts or {})

  -- Initialize features
  for _, f in pairs(Config.features) do
    -- Set defaults if they don't exist
    if f.on == nil then f.on = false end
    if f.defer == nil then f.defer = false end
    if f.commands == nil then f.commands = function() end end
    if f.enable == nil then f.enable = function() end end
    if f.disable == nil then f.disable = function() end end

    -- Init
    if f.on then
      f.commands()
    end
  end

  -- Initialize behaviours
  for _, b in pairs(Config.behaviours) do
    -- Set defaults if they don't exist
    if b.on == nil then b.on = false end
    if b.features_disabled == nil then b.features_disabled = {} end
    if b.init == nil then b.init = function() end end

    -- Init
    if b.on then
      b.init()
    end
  end

  -- Initialize commands
  require('faster.commands')
end

M.config = M.setup

return M
