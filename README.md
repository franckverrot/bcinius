# BCinius

An implementation of the well-known `bc`, with Rubinius.

# USAGE

Almot like the regular `bc`:

```shell
λ make console
RUBYLIB=lib ruby -w bin/bc

  bcinius Copyright (C) 2014 Franck Verrot <franck@verrot.fr>
  This program comes with ABSOLUTELY NO WARRANTY; for details type `rake license'.
  This is free software, and you are welcome to redistribute it
  under certain conditions; type `rake license' for details.

  [Enter an expression and type enter. Ctrl-d to quit]

> 42*2
=> 84
> 42 + wat
=> Caught parsing error...
              42 + wat
Error is here ~~~~~^
> [Ctrl-d]Quitting...
```


# LICENSE

GPLv3. Copyright 2014 - Franck Verrot.
