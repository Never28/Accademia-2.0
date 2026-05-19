@echo off
echo.
echo Checking to see if there is a previous module. If prompted, type 'Y' to delete the current module and module folder. 
echo If you are canceling, you can close the window and exit. nasher will not continue if there is a module file and folder.
echo It will automatically continue if you do not have module built (clean slate) 
echo.
echo WARNING: Continuing will rebuild the module from source, deleting all unsaved changes! Commit or stash your changes, or exit out.
@echo on

del .build\modules /S
rd .build\modules

md .build

rmdir /s /q  .build\override
robocopy override .build\override

md .build\database
md .build\movies
md .build\modules
md .build\config

nasher install --verbose --installDir:"%CD%/.build"

pause