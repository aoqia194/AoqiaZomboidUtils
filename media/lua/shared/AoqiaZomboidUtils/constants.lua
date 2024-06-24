-- -------------------------------------------------------------------------- --
--                   Stores constants to be used everywhere.                  --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local constants = {}

constants.IS_CLIENT = isClient() == true
constants.IS_DEBUG = getDebug() == true
constants.IS_SERVER = isServer() == true

constants.IS_LAST_STAND = getCore():getGameMode() == "LastStand"

return constants
