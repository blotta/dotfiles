
echo "INITIALIZING AUTOLOAD PLUGIN"

python3 << PYEND
def my_auto_func():
    print("This is my autoloaded function", vim.eval("expand('%:p')"))
PYEND

function blt#MyAutoFunc()
    :py3 my_auto_func()
endfunction
