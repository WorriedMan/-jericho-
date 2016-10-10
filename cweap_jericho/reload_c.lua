local blockedTasks = 
{
	"TASK_SIMPLE_IN_AIR", -- We're falling or in a jump.
	"TASK_SIMPLE_JUMP", -- We're beginning a jump
	"TASK_SIMPLE_LAND", -- We're landing from a jump
	"TASK_SIMPLE_GO_TO_POINT", -- In MTA, this is the player probably walking to a car to enter it
	"TASK_SIMPLE_NAMED_ANIM", -- We're performing a setPedAnimation
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE", -- Opening a car door
	"TASK_SIMPLE_CAR_GET_IN", -- Entering a car
	"TASK_SIMPLE_CLIMB", -- We're climbing or holding on to something
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD", -- When we try to jump but something hits us on the head
	"TASK_SIMPLE_FALL", -- We fell
	"TASK_SIMPLE_GET_UP" -- We're getting up from a fall
}

function reloadWeapon()
	-- Usually, getting the simplest task is enough to suffice
	local task = getPedSimplestTask (localPlayer) 

	-- Iterate through our list of blocked tasks
	for idx, badTask in ipairs(blockedTasks) do
		-- If the player is performing any unwanted tasks, do not fire an event to reload
		if (task == badTask) then
			return
		end
	end
	if not getControlState ( "aim_weapon" ) then
		triggerServerEvent("relWep", resourceRoot)
	end
end