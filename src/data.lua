-- override shoot sound for laser turrets
if settings.startup["pew-pew-laser-turret-pew"].value then
  data.raw.beam["laser-beam"].working_sound =
      {sound = {filename = "__PEW-PEW__/sounds/pew.ogg", volume = 1}}
end

-- override shoot sound for gun turrets
if settings.startup["pew-pew-gun-turret-bam"].value then
    data.raw["ammo-turret"]["gun-turret"].attack_parameters.sound =
        {{filename = "__PEW-PEW__/sounds/bambambam.ogg", volume = 1}}
end

-- add wilhelm scream to existing list of dying sounds for biters
if settings.startup["pew-pew-wilhelm"].value then
    units = {"small-biter", "medium-biter", "big-biter", "behemoth-biter"}
    wilhelm_scream = {
        filename = "__PEW-PEW__/sounds/wilhelm.ogg",
        -- wilhelm scream is never subtle
        volume = 1
    }
    for key, value in pairs(units) do
        sound = data.raw["unit"][value].dying_sound
        sound[#sound + 1] = wilhelm_scream
    end
end
