-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = "skylineistback:getSharedObject", -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
    
    ["esx_society:registerSociety"] = "jobsundso:registerSociety",
    ["esx_society:getSociety"] = "jobsundso:getSociety",
    
    ["esx_addonaccount:getSharedAccount"] = "accountoderso:getSharedAccount",

    ["esx_datastore:getSharedDataStore"] = "datastoreistvollkuhl:getSharedDataStore",
    ["esx_datastore:getDataStore"] = "datastoreistvollkuhl:getDataStore",

    ["esx_ambulancejob:revive"] = "esx_ambulancejob:revive",
    ["esx_ambulancejob:heal"] = "esx_ambulancejob:heal",
}

-- Skips or not if an item exists (useful with inventories that doesn't save items in database or in ESX.Items table, example ox_inventory)
SKIP_ITEM_EXISTS_CHECK = true

-- Enable or not the integration for ox_inventory for ESX.Items table
USE_OX_INVENTORY = false

-- For QBCore boss marker (qb-bossmenu or qb-management)
PREFERRED_BOSS_SCRIPT = "qb-management"

-- Default duty status on join for QBCore
DEFAULT_DUTY_STATUS = true