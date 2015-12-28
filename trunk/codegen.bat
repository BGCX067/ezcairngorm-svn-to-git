rem Batch needs the msxsl.exe command line utility 
rem You may get it here http://www.microsoft.com/downloads/details.aspx?FamilyID=2FB55371-C94E-4373-B0E9-DB4816552E41&displaylang=en

cls

set XSLPROC=C:\usr\Tools\msxsl.exe
set MYSQLDUMP=c:\usr\MySQL4\bin\mysqldump.exe
set DAO_NS=com.novacom.tracker
set DB_NAME=advtracker
set DB_HOST=localhost
set DB_USER=""
set DB_PASS=""
set DST_PATH=.\test

rmdir /S /Q %DST_PATH%\temp
mkdir %DST_PATH%\temp

%MYSQLDUMP% -X --no-data -u %DB_USER% -p%DB_PASS% %DB_NAME% > %DST_PATH%\temp\db_schema.xml

%XSLPROC% %DST_PATH%\temp\db_schema.xml .\stylesheets\mysql4_schema_to_obj_schema.xsl -o    %DST_PATH%\temp\obj_schema.xml ns=%DAO_NS%

php -q .\scripts\prepare_obj_schema.php %DST_PATH%\temp\obj_schema.xml

%XSLPROC% %DST_PATH%\temp\obj_schema.xml .\stylesheets\obj_schema_to_flex_vo.xsl -o         %DST_PATH%\temp\code_flex_vo.txt
%XSLPROC% %DST_PATH%\temp\obj_schema.xml .\stylesheets\obj_schema_to_flex_commands.xsl -o   %DST_PATH%\temp\code_flex_commands.txt
%XSLPROC% %DST_PATH%\temp\obj_schema.xml .\stylesheets\obj_schema_to_flex_delegates.xsl -o  %DST_PATH%\temp\code_flex_delegates.txt
%XSLPROC% %DST_PATH%\temp\obj_schema.xml .\stylesheets\obj_schema_to_flex_events.xsl -o     %DST_PATH%\temp\code_flex_events.txt

php -q .\scripts\code_plotter.php %DST_PATH%\temp %DST_PATH%

::rmdir /S /Q %DST_PATH%\temp
