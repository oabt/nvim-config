return { -- TEMPLATE ONLY
    name = "DO NOT launch this template",
    type = "codelldb",
    request = "launch",

    program = "/home/wujj/proj/gem5_src/build/X86/gem5.debug",
    -- path on windows example:
    -- program = "G:/repos/DRAMSim3/dramsim3main.exe",

    args = { -- arg strings that seperated by space
        "/home/wujj/proj/extra_gem5/configs/se_exp/se.py",
        "--cpu-type=DerivO3CPU", "--num-cpus=1", "--caches", "--l1d_size=16kB", "--l1i_size=16kB", "--l1d_assoc=4", "--l1i_assoc=4",
        "--l2-victim-cache", "--l2_size=1MB", "--l2_assoc=8", "--vb-size=1MB", "--vb-assoc=32",
        "--cmd=/home/wujj/Documents/benchmarks/npb-hooks/NPB3.3.1/NPB3.3-OMP/bin/bt.S.x",
    },

    -- cwd for execute the program
    cwd = "/home/wujj/proj/gem5_src",

    -- environment vars to set,
    -- in addition to the vars inherited from the parent process
    env = {
        --EXAMPLE: existing var can be refer by ${env:NAME}
        ["MY_VAR"] = "${env:HOME}/bin:${env:PATH}",
    },

    -- whether to stop on beginning
    stopOnEntry = false,

    -- "path": add breakpoints to file with exact full path (default)
    -- "file": add breakpoints to all the files with exact file name
    breakpointMode = "path",

    sourceMap = {
        -- EXAMPLE: [PATH that listed in 'debug_info show'] = 'PATH' that the actual source file path opened with nvim
        ["/home/wujj/proj/gem5_src/build/X86/victim_cache"] = "/home/wujj/proj/extra_gem5/src/victim_cache",
        ["/home/wujj/proj/gem5_src/build/X86/"] = "/home/wujj/proj/gem5_src/src/",
    },
}

-- to load the template, init.lua in this directory is required
-- example:
-- local templates = 'dap_setup.cpp_templates.'
-- return {
--     require(templates .. 'config_template'),
--     -- other templates to load
-- }
--

