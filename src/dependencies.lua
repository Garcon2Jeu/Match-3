require "src.globals"

Class = require "src.libraries.class"
Push = require "src.libraries.push"
Timer = require "src.libraries.knife.timer"
Chain = require "src.libraries.knife.chain"

App = require "src.App"

require "src.managers.StateManager"
Assets = require "src.managers.AssetsManager"
require "src.managers.AtlasManager"

require "src.states.BaseState"
require "src.states.StartState"
require "src.states.NewGameState"
require "src.states.PlayState"
