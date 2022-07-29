# Updates to qb-core versions after April 26 will not be supported, any modifications to be compatible with qb-core versions after that time will be made by everyone themselves.
# Driver School
🅿 Best driving school for qb-core framework 🅿

## Dependencies:
- [qb-core](https://github.com/qbcore-framework/qb-core) -Main framework
- [qb-target](https://github.com/BerkieBb/qb-target) 

## Preview:
[Preview - Youtube](https://youtu.be/du1YJ7e7D8o)

## Features(All in one):
- Many classes of driver's license
- Edited and inspired by esx_dmvschool
- Support multiple languages
- You can translate through your language easily through `locales\yourlang.lua`
- Easy configuration via `config.lua`

## Installation:

### Manual:
- Download the script and put it in the `resources` directory.
- Add the following code to your server.cfg/resouces.cfg
```
ensure drivingschool
```
### Edit the resources according to the following instructions:

#### qb-core:
- Edit qb-core\server\player.lua:

```
PlayerData.metadata['licences'] = PlayerData.metadata['licences'] or {
        ['N'] = false, -- theory
		['A'] = false, -- motorcycle
		['B'] = false, -- car
		['C'] = false, -- trunk
		['D'] = false, -- bus
		--['driver'] = false,
        ['business'] = false,
        ['weapon'] = false
    }
```
- Edit qb-core\shared\main.lua:

```
QBShared.StarterItems = {
    ['phone'] = { amount = 1, item = 'phone' },
    ['id_card'] = { amount = 1, item = 'id_card' },
    --['driver_license'] = { amount = 1, item = 'driver_license' },
}
```

#### qb-cityhall:

- Edit qb-cityhall\client\main.lua:

```
local idTypes = {
    ["id_card"] = {
        label = "ID Card",
        item = "id_card"
    },
    ["a_driver_license"] = {
        label = "Class A Drivers License",
        item = "driver_license",
		type = 'A'
    },
	["b_driver_license"] = {
        label = "Class B Drivers License",
        item = "driver_license",
		type = 'B'
    },
	["c_driver_license"] = {
        label = "Class C Drivers License",
        item = "driver_license",
		type = 'C'
    },
	["d_driver_license"] = {
        label = "Class D Drivers License",
        item = "driver_license",
		type = 'D'
    },
    ["weaponlicense"] = {
        label = "Firearms License",
        item = "weaponlicense",
		type = 'A'
    }
}
```

```
RegisterNUICallback('requestLicenses', function(data, cb)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = {}

    for type,_ in pairs(licensesMeta) do
        if licensesMeta[type] and type ~= "N" and type ~= "driver" then
            local licenseType = nil
            local label = nil

            if type == "A" then
                licenseType = "a_driver_license"
                label = "Class A Drivers Licence"
			elseif type == "B" then
                licenseType = "b_driver_license"
                label = "Class B Drivers Licence"
			elseif type == "C" then
                licenseType = "c_driver_license"
                label = "Class C Drivers Licence"
			elseif type == "D" then
                licenseType = "d_driver_license"
                label = "Class D Drivers Licence"
            elseif type == "weapon" then
                licenseType = "weaponlicense"
                label = "Firearms License"
            end

            availableLicenses[#availableLicenses+1] = {
                idType = licenseType,
                label = label
            }
        end
    end
    cb(availableLicenses)
end)
```

- Edit Edit qb-cityhall\html\app.js:

```
$(document).on("click", ".identity-page-block", function(e){
    e.preventDefault();

    var idType = $(this).data('type');

    selectedIdentityType = idType;

    if (selectedIdentity == null) {
        $(this).addClass("identity-selected");
        $(".hover-description").fadeIn(10);
        selectedIdentity = this;
        if (idType == "id_card") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Buy $50</p>")
        } else if (idType == "a_driver_license") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Buy $50</p>")
		} else if (idType == "b_driver_license") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Buy $50</p>")
		} else if (idType == "c_driver_license") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Buy $50</p>")
		} else if (idType == "d_driver_license") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Buy $50</p>")
        } else if (idType == "weaponlicense") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Buy $50</p>")
        }
    } else if (selectedIdentity == this) {
        $(this).removeClass("identity-selected");
        selectedIdentity = null;
        $(".request-identity-button").fadeOut(100);
    } else {
        $(selectedIdentity).removeClass("identity-selected");
        $(this).addClass("identity-selected");
        selectedIdentity = this;
        if (idType == "id_card") {
            $(".request-identity-button").html("<p>Buy</p>")
        } else if (idType == "a_driver_license") {
            $(".request-identity-button").html("<p>Buy</p>")
		} else if (idType == "b_driver_license") {
            $(".request-identity-button").html("<p>Buy</p>")
		} else if (idType == "c_driver_license") {
            $(".request-identity-button").html("<p>Buy</p>")
		} else if (idType == "d_driver_license") {
            $(".request-identity-button").html("<p>Buy</p>")
        } else if (idType == "weaponlicense") {
            $(".request-identity-button").html("<p>Buy</p>")
        }
    }
});
```
#### qb-hud:

- Add to qb-hud\client.lua:

```
local function checkseatbelt()
	return seatbeltOn
end

exports('checkseatbelt', checkseatbelt)
```

## My other scripts:
- [MojiaGarages](https://github.com/hoangducdt/MojiaGarages) -Best advanced garages for QB-Core Framework
- [MojiaVehicleKeys](https://github.com/hoangducdt/MojiaVehicleKeys) -Best VehicleKeys for QB-Core Framework
## Note:
- This script is completely free for community, it is strictly forbidden to use this script for commercial purposes.
- If you want to offer me a cup of coffee, you can donate to me through:
    [https://www.buymeacoffee.com/hoangducdt](https://www.buymeacoffee.com/hoangducdt)
    or [paypal.me/hoangducdt](paypal.me/hoangducdt)
- Follow me on [My Github](https://github.com/hoangducdt) or subscribe to [My Youtube Channel](https://www.youtube.com/channel/UCFIsOgj9zvEWAwFTPRT5mbQ) for latest updates
- My Discord: ✯✯✯✯✯#8386
- My Discord Channel: [https://discord.gg/hD3EFzpjfq](https://discord.gg/hD3EFzpjfq)
