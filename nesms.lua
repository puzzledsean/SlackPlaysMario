-- A function to read text files
function read_file (filename)
    input = io.open(filename, 'r') -- Open this file with the read flag.
    io.input(input) -- Set the input that the io library will read from.
    input_content = io.read() -- Read the contents of the file.
    io.close(input) -- Close the file.

    -- delete the command
    input = io.open(filename, "w")
    io.input(input)
    io.write("")
    io.close(input) -- Close the file.
 
    return input_content
end

prev_command=''
inputTable = joypad.read(1);

while (true) do
    prev_command = read_file('commands.txt')

    if prev_command ~= nil then
        print(prev_command)
        
        if prev_command == 'a' then
            -- short hop
            for i = 0,10,1 do
                inputTable['A'] = true
                joypad.set(1, inputTable);
                joypad.write(1, inputTable);
                emu.frameadvance();
            end

            -- lift key up
            inputTable['A'] = false
            joypad.set(1, inputTable);
            joypad.write(1, inputTable);
            emu.frameadvance();
        elseif prev_command == 'A' then
            -- long hop
            for i = 0,100,1 do
                inputTable[prev_command] = true
                joypad.set(1, inputTable);
                joypad.write(1, inputTable);
                -- print(joypad.read(1));
                emu.frameadvance();
            end
            inputTable['A'] = false
            joypad.set(1, inputTable);
            joypad.write(1, inputTable);
            emu.frameadvance();
        -- execute key as normal
        else 
            -- input key
            for i = 0,5,1 do
                inputTable[prev_command] = true
                joypad.set(1, inputTable);
                joypad.write(1, inputTable);
                emu.frameadvance();
            end

            -- lift key up
            inputTable[prev_command] = false
            joypad.set(1, inputTable);
            joypad.write(1, inputTable);
            emu.frameadvance();
        end

        prev_command = nil 
    end
    emu.frameadvance();
end;
