local Components = {
    {label = "Geschlecht",                   name = 'sex',           value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Gesicht",                  name = 'face',          value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Hautfarbe",                  name = 'skin',          value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Falten",              name = 'age_1',         value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Falten-Stärke",     name = 'age_2',         value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Bart-Stil",            name = 'beard_1',       value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Bart-Sichtbarkeit",            name = 'beard_2',       value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Bart-Farbe (1)",         name = 'beard_3',       value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Bart-Farbe (2)",         name = 'beard_4',       value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Haare (1)",                name = 'hair_1',        value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Haare (2)",                name = 'hair_2',        value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Haarfarbe (1)",          name = 'hair_color_1',  value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Haarfarbe (2)",          name = 'hair_color_2',  value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Augenbrauen-Sichtbarkeit",          name = 'eyebrows_2',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Augenbrauen-Stil",          name = 'eyebrows_1',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Augenbrauen-Farbe (1)",       name = 'eyebrows_3',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Augenbrauen-Farbe (2)",       name = 'eyebrows_4',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Make-Up-Stil",           name = 'makeup_1',      value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Make-Up-Sichtbarkeit",      name = 'makeup_2',      value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Make-Up-Farbe (1)",        name = 'makeup_3',      value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Make-Up-Farbe (2)",        name = 'makeup_4',      value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Lippenstift-Stil",         name = 'lipstick_1',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Lippenstift-Stärke",    name = 'lipstick_2',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Lippenstift-Farbe (1)",      name = 'lipstick_3',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Lippenstift-Farbe (2)",      name = 'lipstick_4',    value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Ohr-Accessoire",       name = 'ears_1',        value = -1, min = -1, zoomOffset = 0.4,   camOffset = 0.65},
    {label = "Ohr-Accessoire-Farbe", name = 'ears_2',        value = 0,  min = 0,  zoomOffset = 0.4,   camOffset = 0.65, textureof = 'ears_1'},
    {label = "T-Shirt (1)",              name = 'tshirt_1',      value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15},
    {label ="T-Shirt (2)",              name = 'tshirt_2',      value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15, textureof = 'tshirt_1'},
    {label = "Torso (1)",               name = 'torso_1',       value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15},
    {label = "Torso (2)",               name = 'torso_2',       value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15, textureof = 'torso_1'},
    {label = "Aufkleber (1)",              name = 'decals_1',      value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15}, 
    {label = "Aufkleber (2)",              name = 'decals_2',      value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15, textureof = 'decals_1'},
    {label = "Arme",                  name = 'arms',          value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15},
    {label = "Hose (1)",               name = 'pants_1',       value = 0,  min = 0,  zoomOffset = 0.8,   camOffset = -0.5},
    {label = "Hose (2)",               name = 'pants_2',       value = 0,  min = 0,  zoomOffset = 0.8,   camOffset = -0.5, textureof = 'pants_1'},
    {label = "Schuhe (1)",               name = 'shoes_1',       value = 0,  min = 0,  zoomOffset = 0.8,   camOffset = -0.8},
    {label = "Schuhe (2)",               name = 'shoes_2',       value = 0,  min = 0,  zoomOffset = 0.8,   camOffset = -0.8, textureof = 'shoes_1'},
    {label = "Maske (1)",                name = 'mask_1',        value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Maske (2)",                name = 'mask_2',        value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65, textureof = 'mask_1'},
    {label = "Schutzweste (1)",              name = 'bproof_1',      value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15},
    {label = "Schutzweste (2)",              name = 'bproof_2',      value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15, textureof = 'bproof_1'},
    {label = "Kette (1)",               name = 'chain_1',       value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Kette (2)",               name = 'chain_2',       value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65, textureof = 'chain_1'},
    {label = "Kopfbedeckung (1)",              name = 'helmet_1',      value = -1, min = -1, zoomOffset = 0.6,   camOffset = 0.65, componentId = 0 },
    {label = "Kopfbedeckung (2)",              name = 'helmet_2',      value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65, textureof = 'helmet_1'},
    {label = "Brille (1)",             name = 'glasses_1',     value = -1,  min = -1,  zoomOffset = 0.6,   camOffset = 0.65},
    {label = "Brille (2)",             name = 'glasses_2',     value = 0,  min = 0,  zoomOffset = 0.6,   camOffset = 0.65, textureof = 'glasses_1'},
    {label = "Tasche (1)",                   name = 'bags_1',        value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15},
    {label = "Tasche (2)",             name = 'bags_2',        value = 0,  min = 0,  zoomOffset = 0.75,  camOffset = 0.15, textureof = 'bags_1'}
  }
  
  local LastSex     = -1
  local LoadSkin    = nil
  local LoadClothes = nil
  local Character   = {}
  
  for i=1, #Components, 1 do
    Character[Components[i].name] = Components[i].value
  end
  
  function LoadDefaultModel(malePed, cb)
  
    local playerPed = GetPlayerPed(-1)
    local characterModel
  
    if malePed then
      characterModel = GetHashKey('mp_m_freemode_01')
    else
      characterModel = GetHashKey('mp_f_freemode_01')
    end
  
    RequestModel(characterModel)
  
    Citizen.CreateThread(function()
  
      while not HasModelLoaded(characterModel) do
        RequestModel(characterModel)
        Citizen.Wait(0)
      end
  
      if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
        SetPlayerModel(PlayerId(), characterModel)
        SetPedDefaultComponentVariation(playerPed)
      end
  
      SetModelAsNoLongerNeeded(characterModel)
  
      if cb ~= nil then
        cb()
      end
  
      TriggerEvent('skinändernduhs:modelLoaded')
  
    end)
  
  end
  
  function GetMaxVals()
  
    local playerPed = GetPlayerPed(-1)
  
    local data = {
      sex           = 1,
      face          = 45,
      skin          = 45,
      age_1         = GetNumHeadOverlayValues(3)-1,
      age_2         = 10,
      beard_1       = GetNumHeadOverlayValues(1)-1,
      beard_2       = 10,
      beard_3       = GetNumHairColors()-1,
      beard_4       = GetNumHairColors()-1,
      hair_1        = GetNumberOfPedDrawableVariations(playerPed, 2) - 1,
      hair_2        = GetNumberOfPedTextureVariations(playerPed, 2, Character['hair_1']) - 1,
      hair_color_1  = GetNumHairColors()-1,
      hair_color_2  = GetNumHairColors()-1,
      eyebrows_1    = GetNumHeadOverlayValues(2)-1,
      eyebrows_2    = 10,
      eyebrows_3    = GetNumHairColors()-1,
      eyebrows_4    = GetNumHairColors()-1,
      makeup_1      = GetNumHeadOverlayValues(4)-1,
      makeup_2      = 10,
      makeup_3      = GetNumHairColors()-1,
      makeup_4      = GetNumHairColors()-1,
      lipstick_1    = GetNumHeadOverlayValues(8)-1,
      lipstick_2    = 10,
      lipstick_3    = GetNumHairColors()-1,
      lipstick_4    = GetNumHairColors()-1,
      ears_1        = GetNumberOfPedPropDrawableVariations  (playerPed, 1) - 1,
      ears_2        = GetNumberOfPedPropTextureVariations   (playerPed, 1, Character['ears_1'] - 1),
      tshirt_1      = GetNumberOfPedDrawableVariations      (playerPed, 8) - 1,
      tshirt_2      = GetNumberOfPedTextureVariations       (playerPed, 8, Character['tshirt_1']) - 1,
      torso_1       = GetNumberOfPedDrawableVariations      (playerPed, 11) - 1,
      torso_2       = GetNumberOfPedTextureVariations       (playerPed, 11, Character['torso_1']) - 1,
      decals_1      = GetNumberOfPedDrawableVariations      (playerPed, 10) - 1,
      decals_2      = GetNumberOfPedTextureVariations       (playerPed, 10, Character['decals_1']) - 1,
      arms          = GetNumberOfPedDrawableVariations      (playerPed, 3) - 1,
      pants_1       = GetNumberOfPedDrawableVariations      (playerPed, 4) - 1,
      pants_2       = GetNumberOfPedTextureVariations       (playerPed, 4, Character['pants_1']) - 1,
      shoes_1       = GetNumberOfPedDrawableVariations      (playerPed, 6) - 1,
      shoes_2       = GetNumberOfPedTextureVariations       (playerPed, 6, Character['shoes_1']) - 1,
      mask_1        = GetNumberOfPedDrawableVariations      (playerPed, 1) - 1,
      mask_2        = GetNumberOfPedTextureVariations       (playerPed, 1, Character['mask_1']) - 1,
      bproof_1      = GetNumberOfPedDrawableVariations      (playerPed, 9) - 1,
      bproof_2      = GetNumberOfPedTextureVariations       (playerPed, 9, Character['bproof_1']) - 1,
      chain_1       = GetNumberOfPedDrawableVariations      (playerPed, 7) - 1,
      chain_2       = GetNumberOfPedTextureVariations       (playerPed, 7, Character['chain_1']) - 1,
      bags_1        = GetNumberOfPedDrawableVariations      (playerPed, 5) - 1,
      bags_2        = GetNumberOfPedTextureVariations       (playerPed, 5, Character['bags_1']) - 1,
      helmet_1      = GetNumberOfPedPropDrawableVariations  (playerPed, 0) - 1,
      helmet_2      = GetNumberOfPedPropTextureVariations   (playerPed, 0, Character['helmet_1']) - 1,
      glasses_1     = GetNumberOfPedPropDrawableVariations  (playerPed, 1) - 1,
      glasses_2     = GetNumberOfPedPropTextureVariations   (playerPed, 1, Character['glasses_1'] - 1),
    }
  
    return data
  
  end
  
  function ApplySkin(skin, clothes)
  
    local playerPed = GetPlayerPed(-1)
  
    for k,v in pairs(skin) do
      Character[k] = v
    end
  
    if clothes ~= nil then
  
      for k,v in pairs(clothes) do
        if
          k ~= 'sex'          and
          k ~= 'face'         and
          k ~= 'skin'         and
          k ~= 'age_1'        and
          k ~= 'age_2'        and
          k ~= 'beard_1'      and
          k ~= 'beard_2'      and
          k ~= 'beard_3'      and
          k ~= 'beard_4'      and
          k ~= 'hair_1'       and
          k ~= 'hair_2'       and
          k ~= 'hair_color_1' and
          k ~= 'hair_color_2' and
          k ~= 'eyebrows_1'   and
          k ~= 'eyebrows_2'   and
          k ~= 'eyebrows_3'   and
          k ~= 'eyebrows_4'   and
          k ~= 'makeup_1'     and
          k ~= 'makeup_2'     and
          k ~= 'makeup_3'     and
          k ~= 'makeup_4'     and
          k ~= 'lipstick_1'   and
          k ~= 'lipstick_2'   and
          k ~= 'lipstick_3'   and
          k ~= 'lipstick_4'
        then
          Character[k] = v
        end
      end
  
    end
  
    SetPedHeadBlendData     (playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
  
    SetPedHairColor         (playerPed,       Character['hair_color_1'],   Character['hair_color_2'])           -- Hair Color
    SetPedHeadOverlay       (playerPed, 3,    Character['age_1'],         (Character['age_2'] / 10) + 0.0)      -- Age + opacity
    SetPedHeadOverlay       (playerPed, 1,    Character['beard_1'],       (Character['beard_2'] / 10) + 0.0)    -- Beard + opacity
    SetPedHeadOverlay       (playerPed, 2,    Character['eyebrows_1'],    (Character['eyebrows_2'] / 10) + 0.0) -- Eyebrows + opacity
    SetPedHeadOverlay       (playerPed, 4,    Character['makeup_1'],      (Character['makeup_2'] / 10) + 0.0)   -- Makeup + opacity
    SetPedHeadOverlay       (playerPed, 8,    Character['lipstick_1'],    (Character['lipstick_2'] / 10) + 0.0) -- Lipstick + opacity
    SetPedComponentVariation(playerPed, 2,    Character['hair_1'],         Character['hair_2'], 2)              -- Hair
    SetPedHeadOverlayColor  (playerPed, 1, 1, Character['beard_3'],        Character['beard_4'])                -- Beard Color
    SetPedHeadOverlayColor  (playerPed, 2, 1, Character['eyebrows_3'],     Character['eyebrows_4'])             -- Eyebrows Color
    SetPedHeadOverlayColor  (playerPed, 4, 1, Character['makeup_3'],       Character['makeup_4'])               -- Makeup Color
    SetPedHeadOverlayColor  (playerPed, 8, 1, Character['lipstick_3'],     Character['lipstick_4'])             -- Lipstick Color
  
    if Character['ears_1'] == -1 then
      ClearPedProp(playerPed, 2)
    else
      SetPedPropIndex(playerPed, 2, Character['ears_1'], Character['ears_2'], 2)  -- Ears Accessories
    end
  
    SetPedComponentVariation(playerPed, 8,  Character['tshirt_1'],  Character['tshirt_2'], 2)     -- Tshirt
    SetPedComponentVariation(playerPed, 11, Character['torso_1'],   Character['torso_2'], 2)      -- torso parts
    SetPedComponentVariation(playerPed, 3,  Character['arms'], 0, 2)                              -- torso
    SetPedComponentVariation(playerPed, 10, Character['decals_1'],  Character['decals_2'], 2)     -- decals
    SetPedComponentVariation(playerPed, 4,  Character['pants_1'],   Character['pants_2'], 2)      -- pants
    SetPedComponentVariation(playerPed, 6,  Character['shoes_1'],   Character['shoes_2'], 2)      -- shoes
    SetPedComponentVariation(playerPed, 1,  Character['mask_1'],    Character['mask_2'], 2)       -- mask
    SetPedComponentVariation(playerPed, 9,  Character['bproof_1'],  Character['bproof_2'], 2)     -- bulletproof
    SetPedComponentVariation(playerPed, 7,  Character['chain_1'],   Character['chain_2'], 2)      -- chain
    SetPedComponentVariation(playerPed, 5,  Character['bags_1'],    Character['bags_2'], 2)       -- Bag
  
    if Character['helmet_1'] == -1 then
      ClearPedProp(playerPed, 0)
    else
      SetPedPropIndex(playerPed, 0, Character['helmet_1'], Character['helmet_2'], 2)  -- Helmet
    end
  
    SetPedPropIndex(playerPed, 1, Character['glasses_1'], Character['glasses_2'], 2)  -- Glasses
  
  end
  
  AddEventHandler('skinändernduhs:loadDefaultModel', function(loadMale, cb)
    LoadDefaultModel(loadMale, cb)
  end)
  
  AddEventHandler('skinändernduhs:getData', function(cb)
  
    local components = json.decode(json.encode(Components))
  
    for k,v in pairs(Character) do
      for i=1, #components, 1 do
        if k == components[i].name then
          components[i].value = v
          --components[i].zoomOffset = Components[i].zoomOffset
          --components[i].camOffset = Components[i].camOffset
        end
      end
    end
  
    cb(components, GetMaxVals())
  end)
  
  AddEventHandler('skinändernduhs:change', function(key, val)
  
    Character[key] = val
  
    if key == 'sex' then
      TriggerEvent('skinändernduhs:loadSkin', Character)
    else
      ApplySkin(Character)
    end
  
  end)
  
  AddEventHandler('skinändernduhs:getSkin', function(cb)
    cb(Character)
  end)
  
  AddEventHandler('skinändernduhs:modelLoaded', function()
  
    ClearPedProp(GetPlayerPed(-1), 0)
  
    if LoadSkin ~= nil then
  
      ApplySkin(LoadSkin)
      LoadSkin = nil
  
    end
  
    if LoadClothes ~= nil then
  
      ApplySkin(LoadClothes.playerSkin, LoadClothes.clothesSkin)
      LoadClothes = nil
  
    end
  
  end)
  
  RegisterNetEvent('skinändernduhs:loadSkin')
  AddEventHandler('skinändernduhs:loadSkin', function(skin, cb)
  
    local playerPed = GetPlayerPed(-1)
    local characterModel
      
    if skin['sex'] ~= LastSex then
  
      LoadSkin = skin
  
      if skin['sex'] == 0 then
        TriggerEvent('skinändernduhs:loadDefaultModel', true, cb)
         elseif skin['sex'] > 1 then
          characterModel = pedList[skin.sex - 1]
      else
        TriggerEvent('skinändernduhs:loadDefaultModel', false, cb)
      end
  
    RequestModel(characterModel)
        
    else
  
      ApplySkin(skin)
  
      if cb ~= nil then
        cb()
      end
  
    end
  
    LastSex = skin['sex']
      
    Citizen.CreateThread(function()
  
      while not HasModelLoaded(characterModel) do
        RequestModel(characterModel)
        Citizen.Wait(0)
      end
  
      if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
        SetPlayerModel(PlayerId(), characterModel)
        SetPedDefaultComponentVariation(playerPed)
      end
  
      SetModelAsNoLongerNeeded(characterModel)
      TriggerEvent('skinändernduhs:modelLoaded')
  
    end)
  
  end)
  
  RegisterNetEvent('skinändernduhs:loadClothes')
  AddEventHandler('skinändernduhs:loadClothes', function(playerSkin, clothesSkin)
  
    local playerPed = GetPlayerPed(-1)
    local characterModel    
      
    if playerSkin['sex'] ~= LastSex then
  
      LoadClothes = {
        playerSkin  = playerSkin,
        clothesSkin = clothesSkin
      }
  
      if playerSkin['sex'] == 0 then
        TriggerEvent('skinändernduhs:loadDefaultModel', true)
      elseif playerSkin['sex'] > 1 then
          characterModel = pedList[playerSkin.sex - 1]
      else
        TriggerEvent('skinändernduhs:loadDefaultModel', false)
      end
  
      RequestModel(characterModel)
        
    else
      ApplySkin(playerSkin, clothesSkin)
    end
  
    LastSex = playerSkin['sex']
  
    Citizen.CreateThread(function()
  
      while not HasModelLoaded(characterModel) do
        RequestModel(characterModel)
        Citizen.Wait(0)
      end
  
      if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
        SetPlayerModel(PlayerId(), characterModel)
        SetPedDefaultComponentVariation(playerPed)
      end
  
      SetModelAsNoLongerNeeded(characterModel)
      TriggerEvent('skinändernduhs:modelLoaded')
  
    end)
      
  end)
  