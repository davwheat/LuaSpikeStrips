-- Made by 72006 D.Wheatley for EPRPC

AddEventHandler('chatMessage', function(source, n, msg)
  msg = string.lower(msg)
  if msg == "/s" then
    CancelEvent()
    TriggerClientEvent('c_setSpike', source)
  elseif msg == "/ds" then
    CancelEvent()
    TriggerClientEvent('c_deleteSpike', source)
  elseif (msg == "/d h") then
    CancelEvent()
    TriggerClientEvent('c_debugHeading', source)
  end
end)