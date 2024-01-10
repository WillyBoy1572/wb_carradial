lib.locale()

local windows = { true, true, true, true }

-- Vehicle Menu
lib.registerRadial({
    id = 'car_doors',
    items = {
        {
            label = locale("back_right"),
            icon = 'car-side',
            keepOpen = true,
            onSelect = function()
                doorToggle(3)
            end
        },
        {
            label = locale("trunk"),
            icon = 'trunk',
            keepOpen = true,
            onSelect = function()
                doorToggle(5)
            end
        },
        {
            label = locale("front_right"),
            icon = 'car-side',
            keepOpen = true,
            onSelect = function()
                doorToggle(1)
            end
        },
        {
            label = locale("front_left"),
            icon = 'car-side',
            keepOpen = true,
            onSelect = function()
                doorToggle(0)
            end
        },
        {
            label = locale("hood"),
            icon = 'car-hood',
            keepOpen = true,
            onSelect = function()
                doorToggle(4)
            end
        },
        {
            label = locale("back_left"),
            icon = 'car-side',
            keepOpen = true,
            onSelect = function()
                doorToggle(2)
            end
        },
    }
})

lib.registerRadial({
    id = 'car_windows',
    items = {
        {
            label = locale("back_right"),
            icon = 'caret-right',
            keepOpen = true,
            onSelect = function()
                windowToggle(2, 3)
            end
        },
        {
            label = locale("co_driver"),
            icon = 'caret-up',
            keepOpen = true,
            onSelect = function()
                windowToggle(1, 1)
            end
        },
        {
            label = locale("driver"),
            icon = 'caret-up',
            keepOpen = true,
            onSelect = function()
                windowToggle(0, 0)
            end
        },
        {
            label = locale("back_left"),
            icon = 'caret-left',
            keepOpen = true,
            onSelect = function()
                windowToggle(3, 2)
            end
        },
    }
})

lib.registerRadial({
    id = 'car_seats',
    items = {
        {
            label = locale("back_right"),
            icon = 'caret-right',
            onSelect = function()
                changeSeat(2)
            end
        },
        {
            label = locale("co_driver"),
            icon = 'caret-up',
            onSelect = function()
                changeSeat(0)
            end
        },
        {
            label = locale("driver"),
            icon = 'caret-up',
            onSelect = function()
                changeSeat(-1)
            end
        },
        {
            label = locale("back_left"),
            icon = 'caret-left',
            onSelect = function()
                changeSeat(1)
            end
        },
    }
})

lib.registerRadial({
    id = 'vehicle_menu',
    items = {
        {
            label = 'Moteur',
            icon = 'power-off',
            onSelect = function()
                if cache.vehicle then
                    local engineRunning = GetIsVehicleEngineRunning(cache.vehicle)

                    if engineRunning then
                        SetVehicleEngineOn(cache.vehicle, false, true, true)
                    else
                        SetVehicleEngineOn(cache.vehicle, true, true, true)
                    end
                end
            end
        },
        {
            label = locale("doors"),
            icon = 'car-side',
            menu = 'car_doors'
        },
        {
            label = locale("windows"),
            icon = 'car-side',
            menu = 'car_windows'
        },
        {
            label = locale("shuff"),
            icon = 'car-side',
            menu = 'car_seats'
        },
        {
            label = locale("trailer"),
            icon = 'car-side',
            menu = 'small_trailer'
        },
    }
})

lib.onCache('vehicle', function(value)
    if value then
        lib.addRadialItem({
            {
                id = 'vehicle',
                label = locale("vehicle_radial_label"),
                icon = 'car',
                menu = 'vehicle_menu'
            }
        })
    else
        lib.removeRadialItem('vehicle')
    end
end)

function doorToggle(door)
    if GetVehicleDoorAngleRatio(cache.vehicle, door) > 0.0 then
        SetVehicleDoorShut(cache.vehicle, door, false, false)
    else
        SetVehicleDoorOpen(cache.vehicle, door, false, false)
    end
end

function changeSeat(seat) -- Check seat is empty and move to it
    if (IsVehicleSeatFree(cache.vehicle, seat)) then
        SetPedIntoVehicle(cache.ped, cache.vehicle, seat)
    end
end

function windowToggle(window, door) -- Check window is open/closed and do opposite
    if GetIsDoorValid(cache.vehicle, door) and windows[window + 1] then
        RollDownWindow(cache.vehicle, window)
        windows[window + 1] = false
    else
        RollUpWindow(cache.vehicle, window)
        windows[window + 1] = true
    end
end