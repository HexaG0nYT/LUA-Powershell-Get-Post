# LUA-Powershell-Get-Post
HTTPS POST/Get using powershell, function made in LUA

### Requirements : Powershell 3+ \[ so u can use invoke-webrequest \]

#### How to use :
```lua
a = get('URL', <OPTIONAL>[headers])
b = post('URL', params)

-- If success, both will return a table. If not nil.
-- Both have the same shit inside so whatever

a['content'] e.g : <!doctype html>
a['statuscode'] e.g : 200
a['statusdescription'] e.g : OK
```

##### Added download(link, filetype, path):
```lua
-- If path is nil, file will automatically go to Downloads folder.
link = 'https://cdn.discordapp.com/attachments/870530253225869332/878305887209529344/a087ab4e3485942f.png'
path = 'C:\\Users\\'..os.getenv('username')..'\\Desktop'
filename = 'TRANSPARENT.png'
download(link, filename, <OPTIONAL>[path])
```

i might add proxy sometime AWAWAWAWAWA
