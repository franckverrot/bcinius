#!/usr/bin/env ruby
script_name = ARGV[0] || raise("Please provide a file name.\nUsage: <script> filename.rbc\n")
cl = Rubinius::CodeLoader.new(script_name)
cm = cl.load_compiled_file(script_name, 1, 1)
script = cm.create_script(false)
script.file_path = script_name
puts MAIN.__script__.inspect
