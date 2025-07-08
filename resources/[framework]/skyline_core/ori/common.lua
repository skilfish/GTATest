AddEventHandler('skylineistback:getSharedObject', function(cb)
	cb(SKYLINE)
end)

function getSharedObject()
	return SKYLINE
end
