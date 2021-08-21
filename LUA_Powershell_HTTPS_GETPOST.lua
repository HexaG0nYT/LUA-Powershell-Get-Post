--21/8/21

function get(link,headers)
    headers=headers or nil
    local res = {}
    local command = '$r=Invoke-WebRequest "'..link..'"'
    if headers then
        local hd = ' -Headers @{'
        for i,v in pairs(headers) do
            hd=hd..'"'..i..'"="'..v..'";'
        end
        command=command..hd:sub(1,-2)..'}'
    end
    command=command..';$r.statuscode;$r.statusdescription;$r.content'
    command='powershell "'..command:gsub('"','\\"')..'"'
    local status = io.popen(command):read('*a')
    if status~='' then
        for i in status:gmatch('[^\n]+') do
            if not res['statuscode'] then
                res['statuscode']=tonumber(i)
            elseif not res['statusdescription'] then
                res['statusdescription']=i
            else
                break
            end
        end
        res['content']=status:sub(#res['statuscode']+#res['statusdescription']+3)
    end
end

function post(url, params)
    local res = {}
    local command = '$r=Invoke-WebRequest "'..url..'" -Method POST'
    local param = ' -Body @{'
    for i,v in pairs(params) do
        i,v=i:gsub('"',"'"),v:gsub('"',"'")
        param=param..'"'..i..'"="'..v..'";'
    end
    command=command..param:sub(1,-2)..'}'
    command=command..';$r.statuscode;$r.statusdescription;$r.content'
    command='powershell "'..command:gsub('"','\\"')..'"'
    local status = io.popen(command):read('*a')
    if status~='' then
        for i in status:gmatch('[^\n]+') do
            if not res['statuscode'] then
                res['statuscode']=tonumber(i)
            elseif not res['statusdescription'] then
                res['statusdescription']=i
            else
                break
            end
        end
        res['content']=status:sub(#res['statuscode']+#res['statusdescription']+3)
        return res
    end
end

-- Extra [ Download file from internet ]

function download(link, filename, path)
    path=path or nil
    if not path then
        path='C:\\Users\\'..os.getenv('username')..'\\Downloads\\'
    else
        if path:sub(#path)~='\\' then
            path=path..'\\'
        end
    end
    path=path..filename
    res = io.popen('powershell Invoke-WebRequest "'..link..'" -OutFile "'..path..'"'):read('*a')
    if res=='' then
        return true
    end
    return false
end

a = get('https://google.com/')

if a then
    if a['statuscode'] == 200 then
        print(a['content'])
    end
end
