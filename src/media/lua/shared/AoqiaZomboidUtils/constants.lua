-- -------------------------------------------------------------------------- --
--                   Stores constants to be used everywhere.                  --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local constants = {}

constants.IS_DEBUG = getDebug()

constants.IS_CLIENT = isClient()
constants.IS_COOP = isClient() and isCoopHost()
constants.IS_SERVER = isServer()
constants.IS_SINGLEPLAYER = isClient() == false and isServer() == false

constants.IS_LAST_STAND = getCore():getGameMode() == "LastStand"

return constants
