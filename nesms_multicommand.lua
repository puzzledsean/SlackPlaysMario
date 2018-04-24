-- A function to read text files
function read_file (filename)
    input = io.open(filename, 'r') -- Open this file with the read flag.
    io.input(input) -- Set the input that the io library will read from.
    input_content = io.read() -- Read the contents of the file.
    io.close(input) -- Close the file.
    
    
    if input_content == nil then
        return {}
    end

    print(input_content)
    -- split on spaces and get all the commands in a table
    words = {}
    for word in input_content:gmatch("%w+") do 
        table.insert(words, word) 
    end

    -- delete the command
    input = io.open(filename, "w")
    io.input(input)
    io.write("")
    io.close(input) -- Close the file.
 
    -- return the word table
    return words 
end

prev_commands={}
inputTable = joypad.read(1);

while (true) do
    prev_commands = read_file('commands.txt')
    num_frames = 10

    if prev_commands ~= {} then
        -- print(prev_commands)
        -- print(table.getn(prev_commands))

        -- go through each command
        -- v is actually the key (for some reason)
        for k, v in pairs(prev_commands) do
            if v == 'A' then
                -- specify a long jump
                num_frames = 30 
            end
        end

        -- actually execute the command combination
        for i = 0,num_frames,1 do
            -- have to keep setting every key to true in order to "hold" down keys
            for k, v in pairs(prev_commands) do
                if v == 'a' then
                    inputTable['A'] = true
                    joypad.set(1, inputTable);
                    joypad.write(1, inputTable);
                elseif v == 'A' then
                    -- specify a long jump
                    -- num_frames = 100
                    inputTable['A'] = true
                    joypad.set(1, inputTable);
                    joypad.write(1, inputTable);
                -- execute key as normal
                else 
                    inputTable[v] = true
                    joypad.set(1, inputTable);
                    joypad.write(1, inputTable);
                end
            end
            emu.frameadvance();
        end
        
        -- lift keys up
        for k, v in pairs(prev_commands) do
            if v == 'a' then
                inputTable['A'] = false 
                joypad.set(1, inputTable);
                joypad.write(1, inputTable);
            elseif v == 'A' then
                -- specify a long jump
                inputTable['A'] = false
                joypad.set(1, inputTable);
                joypad.write(1, inputTable);
            -- execute key as normal
            else 
                inputTable[v] = false
                joypad.set(1, inputTable);
                joypad.write(1, inputTable);
            end
        end
            emu.frameadvance();

        prev_commands = {} 
    end
    emu.frameadvance();
end;
