SetStatus(400)
if not HasParam 'short' then
  Write 'No short alias given.'
elseif not HasParam 'long' then
  Write 'No long URL given.'
else
  short = GetParam 'short'
  long = GetParam 'long'
  if #short > 80 then
    Write 'Short aliases over 80 characters are not allowed.'
  elseif reShort:search(short) == nil then
    Write 'Invalid short alias.'
  elseif reLong:search(long) == nil then
    Write 'Invalid long URL.'
  else
    selectStatement:reset()
    selectStatement:bind_values('/' .. short)
    status = selectStatement:step()
    if status == 100 then
      Write 'Short alias is already in use.'
    else
      SetStatus(200)
      insertStatement:reset()
      insertStatement:bind_values('/' .. short, long)
      status = insertStatement:step()
      Write(status)
    end
  end
end
