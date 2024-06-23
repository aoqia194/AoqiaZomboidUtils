-- -------------------------------------------------------------------------- --
--                   Stores constants to be used everywhere.                  --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local constants = {}

constants.IS_DEBUG = getDebug() == true
constants.IS_LAST_STAND = getCore():getGameMode() == "LastStand"

return constants
