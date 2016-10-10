function superMutantDied (ped)
	if isElement ( ped ) then
		if peds[ped] then
			local players = getPlayersNearBoss(ped)
			for i, v in ipairs ( players ) do
				outputChatBox (getPlayerName(v).." принял участие в убийстве супермутанта" )
			end
		end
	end
end