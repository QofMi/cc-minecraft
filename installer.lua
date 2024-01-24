local githuburl = "https://raw.githubusercontent.com/QofMi/cc-minecraft/main/Programs.txt"

programs = {}

local args = { ... }


function exit(message, error)
    term.setTextColor(error and colors.red or colors.yellow)
    term.write(message .. "\n")
    term.setTextColor(colors.white)
    if error then
        shell.exit()
    end
end


function loadSources()
    local dl, error = http.get(githuburl)
    if dl then
        text = dl.readAll()
        text:gsub("\n", "")
        text:gsub("\\", "")
        programs = textutils.unserialize(text)
    end
end


function delete(program)
    if programs[program] == nil then
        error("Program '" .. program .. "' does not exists!")
    end
    
    if fs.exists("startup") then
        fs.delete("startup")
    end

    for k, v in ipairs(programs[program]["files"]) do
        if fs.exists(program .."/".. v.name) then
            
            term.setTextColor(colors.yellow)
            print("Deleting ".. v.name)

            dir = fs.getDir(program .."/".. v.name)
            fs.delete(program .."/".. v.name)
        end
    end
    fs.delete(program)
    term.setTextColor(colors.lime)
    print("Successfully deleted ".. program)
end


function install(program)
    if programs[program] == nil then
        error("Program '" .. program .. "' does not exists!")
    end

    local startup = programs[program]["startup"]

    if fs.exists("startup") then
        fs.delete("startup")
    end
    local sfile = fs.open("startup", "w")
    sfile.write(startup)
    sfile.close()
    
    libraries = {}
    
    programName = ""
    programPath = ""
    for k, v in ipairs(programs[program]["files"]) do
        if v.type == "program" then
           programPath = v.link 
           programName = v.name
        elseif v.type == "api" then
            table.insert(libraries, v)
        end
    end
    
    for k, v in ipairs(libraries) do
        term.setTextColor(colors.yellow)
        print("Downloading library ".. v.name .."...")
        -- shell.run("wget ".. v.link .." ".. program .."/api/".. v.name)
        shell.run("wget ".. v.link .." ".. program .."/".. v.name)
        term.setTextColor(colors.lime)
        print("Downloaded library ".. v.name)
    end
    
    term.setTextColor(colors.yellow)
    print("Downloading program ".. program .."...")
    shell.run("wget ".. programPath .." ".. program .."/".. programName)
    term.setTextColor(colors.lime)
    print("Successfully installed ".. program)
end


function showList()
    for name, table in pairs(programs) do
        term.setTextColor(colors.green)
        write(name)
        term.setTextColor(colors.lightGray)
        write(" -- ")
        term.setTextColor(colors.cyan)
        write(table.desc .. "\n")
    end
end


function showHelp()
    term.setTextColor(colors.lightGray)
    print("---- [Installer] ----")
    term.setTextColor(colors.white)
    print("installer help              - Shows this menu")
    print("installer list              - Lists all available programs")
    print("installer install <program> - Installs a program")
    print("installer update <program>  - Updates a program")
    print("installer delete <program>  - Deletes a program")
    -- print("installer config <program>  - Configures a program after it is installed")
    term.setTextColor(colors.lightGray)
    print("---- [=========] ----")
    term.setTextColor(colors.white)
end


function executeInput()
    if #args <= 0 then
        showHelp()
    end
    if #args >= 1 and args[1] == "help" then
        showHelp()
    elseif #args >= 1 and args[1] == "list" then
        showList()
    elseif #args >= 1 and args[1] == "install" then
        install(args[2])
    elseif #args >= 1 and args[1] == "update" then
        delete(args[2])
        install(args[2])
    elseif #args >= 1 and args[1] == "delete" then
        delete(args[2])
    -- elseif #args >= 1 and args[1] == "config" then
    --     exit("Not implemented", false)
    elseif #args >= 1 then
        exit("Could not find command '" .. args[1] .. "'", false)
    end
end


loadSources()
executeInput()