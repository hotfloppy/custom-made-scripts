#!/bin/bash

if [ "$1" ==  "-v" ] || [ "$1" == "--version" ]; then 
	echo "+--------------------------------------------------------------------------------+"
	echo "| MySQL Database Size Checker - Version 0.1                                      |"
	echo "+--------------------------------------------------------------------------------+"
	echo "| Copyright (C) 2010 Free Software Foundation, Inc.                              |"
	echo "| License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>. |"
	echo "| This is free software: you are free to change and redistribute it.             |"
	echo "| There is NO WARRANTY, to the extent permitted by law.                          |"
	echo "| Written by Naim (hotfloppy.6866[AT]gmail.com)                                  |"
	echo "+--------------------------------------------------------------------------------+"
	exit 0
fi

arrDB=(`sudo mysql -e "show databases;" | awk '{ print $1 }'`)
DB=""

ListDB() {
	clear
	echo "+---------------------------------+"
    echo "| Databases Listing               |"
    echo "+---------------------------------+"
    for ((i=1; i<${#arrDB[@]}; i++)) {
        echo "[ ${i} ] ${arrDB[${i}]}"
    }
    echo "|"
    echo [ q ] Quit
    echo "+---------------------------------+"
    echo ""
    printf "Key in which database: "
    read DB
    echo ""
    clear
    
    isString=`echo $DB | awk '$0 ~/[^0-9]/ { print "hotfloppy is great" }'` # if isString equals to NULL, means $DB is number
    
    if [ "$DB" == "q" ]; then
    	exit 0
    fi
    
    if [ -z "$isString" ] && [ -n "$DB" ] && [ $DB -gt 0 ] && [ $DB -lt ${#arrDB[@]} ]; then
        ## checking either the DB NULL or not. if NULL, means the DB is empty
        mysql -e "
        		SELECT sum( data_length + index_length )
        		FROM information_schema.TABLES
        		WHERE table_schema = '${arrDB[$DB]}'" | grep NULL > /dev/null
        if [ $? -ne 0 ]; then
            echo "Database size for ${arrDB[$DB]}: "; echo ""
            mysql -e "
            		SELECT table_schema \"DB Name\", 
            		sum( data_length + index_length ) / 1024 / 1024 \"DB Size (MB)\", 
            		sum( data_free )/ 1024 / 1024 \"Free Space (MB)\" 
            		FROM information_schema.TABLES 
            		WHERE table_schema = '${arrDB[$DB]}' 
            		GROUP BY table_schema;"
        else
            echo "+------------------------------------------------------------+"
            echo "| Database: ${arrDB[$DB]}"
            echo "+------------------------------------------------------------+"
            echo "|"
            echo "| This database is empty. Please select another database."
            echo "|"
            echo "+------------------------------------------------------------+"
            echo ""
            read -p "Press any key to continue.."
        	ListDB
        fi
    else
        echo "+------------------------------------------------------------+"
        echo "| Something wrong?"
        echo "+------------------------------------------------------------+"
        echo "|"
        echo "| Selection not valid. Valid value is from 1 - $((${#arrDB[@]}-1))."
        echo "| Please select another database."
        echo "|"
        echo "+------------------------------------------------------------+"
        echo ""
        read -p "Press any key to continue.."
        ListDB
    fi
    echo ""; read -p "Press any key to continue.."; clear
    ListDB
}
ListDB
clear
exit 0
