-- 're' and 'lsqlite3' modules are already included with redbean
re = require 're'
sqlite3 = require 'lsqlite3'

-- For validating the short alias and long URL user inputs
reShort = re.compile[[^(\w|-|_)+$]]
reLong = re.compile[[^https?:\/\/.+$]]

-- Initialize SQLite objects
database = sqlite3.open 'database.sqlite3'
database:exec 'CREATE TABLE IF NOT EXISTS links(short TEXT COLLATE NOCASE, long TEXT COLLATE NOCASE);' -- Both short and long are case-insensitive
selectStatement = database:prepare 'SELECT long FROM links WHERE short = ?;'
insertStatement = database:prepare 'INSERT INTO links VALUES(?, ?);'

function OnHttpRequest()
  path = GetPath()
  if path == '/' or path == '/api.lua' then
    Route()
  else
    selectStatement:reset()
    selectStatement:bind_values(path)
    status = selectStatement:step()
    if status == 100 then -- 100: row returned
      SetStatus(301)
      SetHeader('Location', selectStatement:get_value(0))
    else
      ServeAsset '/index.html'
    end
  end
end
