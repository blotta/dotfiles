# Termite Compilation Instructions


0. Compile vte-ng


1. Change the default term on the termite.cc file from xterm-termite to something else


2. Compile Termite

```sh
PKG_CONFIG_PATH=~/src/vte-ng/ CPATH=~/src/vte-ng/src LIBRARY_PATH=~/src/vte-ng/src/.libs/  make
```

3. Run

```sh
LD_LIBRARY_PATH=~/src/vte-ng/src/.libs/ ./termite 
```

4. Script

`~/bin/termite`
```sh
#!/bin/bash

SRC_DIR=$HOME/src

LD_LIBRARY_PATH=$SRC_DIR/vte-ng/src/.libs/ $SRC_DIR/termite/termite &
```
