QBCore = exports['qb-core']:GetCoreObject()

local function CheckPlayers(vehicle) -- Check if there is someone in the car, if so, get that person out of the car
    for i = -1, 5,1 do                
        seat = GetPedInVehicleSeat(vehicle,i)
        if seat ~= 0 then
            TaskLeaveVehicle(seat,vehicle,0)
            SetVehicleDoorsLocked(vehicle)			
            Wait(3000)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
   end
end

CustomFont = nil --[nil]: use system default font - or ['name of your custom font']: You need your_custum_font.gfx EX: CustomFont = 'Oswald'

Config = {}
Config.scoretopass = 80
Config.SpeedMultiplier = 3.6

Config.Prices = {
	N  = 500, -- theory
	A = 2500, -- motorcycle
	B = 3000, -- car
	C = 5000, -- trunk
	D = 5000, -- bus
	--E = 3000,
	--F = 5000,
	--G = 10000,
}

Config.VehicleModels = {
	A  = 'sanchez',
	B = 'blista',	
	C = 'phantom3',
	D = 'bus',
	--E = '',
	--F = '',
	--G = '',
}

Config.SpeedLimits = {
	residence = 50,
	town      = 80,
	freeway   = 120
}

Config.Zones = {
	VehicleSpawnPoint = {
		Pos   = vector4(249.409, -1407.230, 30.4094, 317.0),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}
}

Config.CheckPoints = {
	{
		Pos = vector3(249.409, -1407.230, 29.537),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()				
				local class = GetVehicleClass(vehicle)
				if class ~= 8 and class ~= 13 and class ~= 14 then
					QBCore.Functions.Notify(Lang:t('info.fasten_your_seat_belt_and_start_the_engine_to_start_the_test'), 'info', 4000)
					PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
					FreezeEntityPosition(vehicle, true)
					Wait(4000)
					while not exports['qb-hud']:checkseatbelt() do
						Wait(100)					
					end
					Wait(100)
					while not GetIsVehicleEngineRunning(vehicle) do
						Wait(100)
					end
					FreezeEntityPosition(vehicle, false)
					QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
				else
					QBCore.Functions.Notify(Lang:t('info.start_the_engine_to_start_the_test'), 'info', 4000)
					PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
					FreezeEntityPosition(vehicle, true)
					Wait(4000)
					while not GetIsVehicleEngineRunning(vehicle) do
						Wait(100)
					end
					FreezeEntityPosition(vehicle, false)
					QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
				end
			end)
		end
	},
	{
		Pos = vector3(255.139, -1400.731, 29.537),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point_the_speed_limit_is_x_kmh', {speed = Config.SpeedLimits['residence']}), 'info', 4000)
		end
	},
	{
		Pos = vector3(271.874, -1370.574, 30.932),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(234.907, -1345.385, 29.542),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()
				QBCore.Functions.Notify(Lang:t('warning.stop_for_pedestrians'), 'warning', 4000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(4000)
				FreezeEntityPosition(vehicle, false)
				QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
			end)
		end
	},
	{
		Pos = vector3(217.821, -1410.520, 28.292),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			CreateThread(function()
				QBCore.Functions.Notify(Lang:t('info.stop_and_look_to_the_left_it_is_time_to_really_drive_on_the_road_the_speed_limits_in_the_city_are_x_kmh', {speed = Config.SpeedLimits['town']}), 'info', 4000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(6000)
				FreezeEntityPosition(vehicle, false)
				QBCore.Functions.Notify(Lang:t('info.very_well_turn_right_and_follow_directions'), 'info', 4000)
			end)
		end
	},
	{
		Pos = vector3(178.550, -1401.755, 27.725),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.watch_the_traffic_and_turn_on_your_lights'), 'info', 4000)
		end
	},
	{
		Pos = vector3(113.160, -1365.276, 27.725),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(-73.542, -1364.335, 27.789),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.stop_for_passing_vehicles'), 'info', 4000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Wait(6000)
			FreezeEntityPosition(vehicle, false)
			QBCore.Functions.Notify(Lang:t('success.very_good_go_to_the_next_point'), 'success', 4000)
		end
	},
	{
		Pos = vector3(-355.143, -1420.282, 27.868),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(-439.148, -1417.100, 27.704),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(-453.790, -1444.726, 27.665),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('freeway')
			QBCore.Functions.Notify(Lang:t('info.it_is_time_to_drive_on_the_highway_speed_limit_x_kmh', {speed = Config.SpeedLimits['freeway']}), 'info', 4000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},
	{
		Pos = vector3(-463.237, -1592.178, 37.519),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(-900.647, -1986.28, 26.109),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(1225.759, -1948.792, 38.718),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.go_to_the_next_point'), 'info', 4000)
		end
	},
	{
		Pos = vector3(1225.759, -1948.792, 38.718),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			QBCore.Functions.Notify(Lang:t('info.entered_town_pay_attention_to_your_speed_speed_limit_x_kmh', {speed = Config.SpeedLimits['town']}), 'info', 4000)
		end
	},
	{
		Pos = vector3(1163.603, -1841.771, 35.679),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.Notify(Lang:t('info.im_impressed_but_dont_forget_to_stay_alert_whilst_driving'), 'info', 4000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},
	{
		Pos = vector3(235.283, -1398.329, 28.921),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CheckPlayers(vehicle)
		end
	}
}

Config.PedList = {
	{
		model = 'ig_paper',
		coords = vector3(210.49, -1381.94, 29.58),               
		heading = 140.35,
		gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
	},
	{
		model = 'ig_paper',
		coords = vector3(250.96, -1413.1, 29.59),              
		heading = 32.17,
		gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
	},
}
