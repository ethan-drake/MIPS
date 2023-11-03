set db_name "sim_database"
set db_folder_name $db_name
append db_folder_name ".smh"
set top_name "risc_v_top_tb"

database -open $db_name -into $db_folder_name -event -default
probe -create $top_name -depth all -tasks -functions -all -database $db_name
run
