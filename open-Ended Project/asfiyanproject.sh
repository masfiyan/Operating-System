#!/bin/bash
# Function to add user
add_user() {
    local user=$1
    local password=$2

    # Add user using the provided username and password
    sudo useradd -m -p $(openssl passwd -1 "$password") $user
}

# Function to check if the user exists and validate the password
check_credentials() {
    local user=$1
    local password=$2

    # Validate the password
    if echo "$password" | su "$user" -c true 2>/dev/null; then
        zenity --info --width=1200 --height=700 --text "Welcome back, $user!" --ok-label "continue" --no-wrap
        return 0
    else
        zenity --info --width=1200 --height=700 --text "Incorrect password for $user. Please try again." --ok-label "OK" --no-wrap
        return 1
    fi
}



#user login

continue_loop=true

while [ "$continue_loop" = true ]; do
    USERNAME=$(zenity --entry --width=1200 --height=700 --title="User Login" --text="User-Name" --entry-text "" --extra-button "Add User" --ok-label "Login" --cancel-label "Quit" ) 
    BUTTON_CLICKED=$?

    # Check if the window is closed or the "Login" button is clicked
    if [ "$BUTTON_CLICKED" -eq 0 ]; then
        PASSWORD=$(zenity --password --width=1200 --height=700 --title="User Login" --text="Enter your password:" --cancel-label "Quit")

        # Check credentials
        if check_credentials "$USERNAME" "$PASSWORD"; then
            break
        else
            zenity --info --width=1200 --height=700 --text "Invalid credentials. Please try again." --ok-label "OK" --no-wrap
        fi
    elif [ "$BUTTON_CLICKED" -eq 1 ]; then

        # Add User button clicked
        USERNAME=$(zenity --entry --title="Add User" --text="Enter new username:" --width=1200 --height=700)
        PASSWORD=$(zenity --password --title="Add User" --text="Enter new password:" --width=1200 --height=700)

        # Add user
        add_user "$USERNAME" "$PASSWORD"
        zenity --info --width=1200 --height=700 --text "User $USERNAME added successfully!" --ok-label "Continue" --no-wrap
	else


		break
	fi


done


# Main functionality list
X=0
X1=0
zenity --info --width=1200 --height=700 --text "Welcome to the Smart Manager" --ok-label "continue" --no-wrap

while [ "$X" -eq "$X1" ]; do
    # Main category selection
    CATEGORY="$(zenity --list --title "MAIN MENU" --column Selection --column Functionality \
        TRUE "System Information" \
        FALSE "User Management" \
        FALSE "Process Management" \
        FALSE "Memory Management" \
        FALSE "Other Activities" \
	FALSE "ShutDown LAPTOP" \
        --width=1000 --height=800 --radiolist --cancel-label "Quit")"
    Stat=$?

    case "$CATEGORY" in
        "System Information")
            while true; do
                SYSTEM_INFO_SELECTION="$(zenity --list --title "SYSTEM INFORMATION" --column Selection --column Functionality \
                    TRUE "Information" \
                    FALSE "System Uptime" \
                    FALSE "Filesystem Information" \
                    --width=1000 --height=800 --radiolist --cancel-label "Back")"
                Stat=$?
                

                case "$SYSTEM_INFO_SELECTION" in
                    "Information")
                        #Funciton to display system info
                         battery=$(upower -i $(upower -e | grep 'BAT'))
                         wifi=$(nmcli radio wifi)
                         bluetooth=$(rfkill list)
                         ch=$(upower -i $(upower -e | grep 'BAT') | grep state)
                          zenity --info --width=1200 --height=700 --text "information:\n$battery \n$wifi \n$bluetooth \n$ch"
                        ;;

 
                    "System Uptime")
                        # Function to display system uptime
                        SYSTEM_UPTIME=$(uptime)
                        zenity --info --width=1200 --height=700 --text "System Uptime:\n$SYSTEM_UPTIME"
                        ;;
                    "Filesystem Information")
                        # Function to display filesystem information
                        FILESYSTEM_INFO=$(df -h)
                        zenity --info --width=1200 --height=700 --text "Filesystem Information:\n$FILESYSTEM_INFO"
                        ;;
                    *)
                        break  # Go back to the main category selection
                        ;;
                esac
            done
            ;;
        "User Management")
            while true; do
                # Sub-category selection for User Management
                SUB_CATEGORY="$(zenity --list --title "USER MANAGEMENT" --column Selection --column Functionality \
                    TRUE  "Add User" \
                    FALSE "All Users" \
                    FALSE "Delete User" \
                    --width=1000 --height=800 --radiolist --cancel-label "Back")"
                Stat=$?

                case "$SUB_CATEGORY" in
                    "Add User")
                    USERNAME=$(zenity --entry --title="Add User" --text="Enter new username:" --width=1200 --height=700)
                    PASSWORD=$(zenity --password --title="Add User" --text="Enter new password:" --width=1200 --height=700)

                     # Add user
                    add_user "$USERNAME" "$PASSWORD"
                    zenity --info --width=1200 --height=700 --text "User $USERNAME added successfully!" --ok-label "Continue" --no-wrap

                    ;;
                    "All Users")
                        # Your code for displaying all users
                        ALL_USERS=$(cut -d: -f1 /etc/passwd)
                        zenity --list --width=1200 --height=700 --title "All Users" --text "List of all users:" --column "Users" "${ALL_USERS[@]}"
                        ;;
                    "Delete User")
                        # Your code for deleting a user
                        USERNAME_TO_DELETE=$(zenity --entry --width=1000 --height=800 --title "Delete User" --text "Please enter the username to delete:")

                        if [ -n "$USERNAME_TO_DELETE" ]; then
                            # Check if the user exists before attempting to delete
                            if id "$USERNAME_TO_DELETE" &>/dev/null; then
                                userdel "$USERNAME_TO_DELETE"
                                zenity --info --width=1200 --height=700 --text "User $USERNAME_TO_DELETE deleted successfully!" --ok-label "OK" --no-wrap
                            else
                                zenity --info --width=1200 --height=700 --text "User $USERNAME_TO_DELETE does not exist." --ok-label "OK" --no-wrap
                            fi
                        else
                            zenity --info --width=1200 --height=700 --text "Please enter a valid username." --ok-label "OK" --no-wrap
                        fi
                        ;;
                    *)
                        break  # Go back to the main category selection
                        ;;
                esac
            done
            ;;
        "Process Management")
            while true; do
                # Sub-category selection for Process Management
                SUB_CATEGORY="$(zenity --list --title "PROCESS MANAGEMENT" --column Selection --column Functionality \
                    TRUE "Running Processes" \
                    FALSE "Kill a Process" \
                    FALSE "Search a Process" \
                    FALSE "Process using most RAM" \
                    FALSE "Process using most CPU" \
                    --width=1000 --height=800 --radiolist --cancel-label "Back")"
                Stat=$?

                case "$SUB_CATEGORY" in
                    "Running Processes")
                     #displaying running processes
                     RPRO=()
                     while IFS= read -r line; do
                       RPRO+=("$line")
                     done < <(top -b | head -300)
                     zenity --list --title "Running Process" --text " " --width=1200 --height=700   --column "PID" --column Process --column "CPU %" "${RPRO[@]}"
                     ;;
                    "Kill a Process")
                        # Your code for killing a process
                        PID="$(zenity --entry --width=1000 --height=800 --title "Kill Process" --text "Please enter PID:")"
                        kill $PID
                        zenity --info --width=1200 --height=700 --text "Request Forwarded!"
                        ;;
                    "Search a Process")
                        # Your code for searching a process
                        key="$(zenity --entry --width=1000 --height=800 --title "Search a Process" --text "Please enter keyword:")"
                        KEYRET=()
                        while IFS= read -r line; do
                            KEYRET+=( "$line" )
                        done < <( ps aux | grep -i "$key" )
                        zenity --list --width=1200 --height=700 --title "Search Result" --text "Results are as follows:" --column PROCESSES "${KEYRET[@]}"
                        ;;
                    "Process using most RAM")
                        # Your code for displaying processes using most RAM
                        MRAM=()
                        while IFS= read -r line; do
                            MRAM+=( "$line" )
                        done < <( ps -eo pid,cmd,%mem,%cpu --sort=-%mem | awk 'NR<=10{print $0}' | head )
                        zenity --list --width=1000 --height=800 --title "Process using most RAM" --text " " --column PROCESS "${MRAM[@]}"
                        ;;
                    "Process using most CPU")
                        # Your code for displaying processes using most CPU
                        MCPU=()
                        while IFS= read -r line; do
                            MCPU+=( "$line" )
                        done < <( ps -eo pid,cmd,%mem,%cpu --sort=-%cpu | awk 'NR<=10{print $0}' | head )
                        zenity --list --width=1000 --height=800 --column PROCESS --title "Process using most CPU" --text " " "${MCPU[@]}"
                        ;;
                    *)
                        break  # Go back to the main category selection
                        ;;
                esac
            done
            ;;
        "Memory Management")
            while true; do
                # Sub-category selection for Memory Management
                SUB_CATEGORY="$(zenity --list --title "MEMORY MANAGEMENT" --column Selection --column Functionality \
                    TRUE "Memory Usage" \
                    FALSE "Disk Usage" \
                    FALSE "Commands History" \
                    FALSE "Search Something in history" \
                    FALSE "Login History" \
                    --width=1000 --height=800 --radiolist --cancel-label "Back")"
                Stat=$?

                case "$SUB_CATEGORY" in
                    "Memory Usage")
                        # Your code for Memory Usage
                        zenity --info --width=1200 --height=700 --text "Memory usage:
                        $(free -m | xargs | awk '{print "\nTotal Memory: " $8 " MB\nUsed Memory: " $9 " MB\nFree Memory: " $10 "MB\nShared Memory: " $11 " MB\n"s}')"
                        ;;
                    "Disk Usage")
                        # Your code for Disk Usage
                        zenity --info --width=1200 --height=700 --text "Disk usage:
                        $(df -h | xargs | awk '{print "\nTotal disk: " $9 " \nFree Disk " $11}')"
                        ;;
                    "Commands History")
                        # Your code for Commands History
                        HISTFILE=~/.bash_history
                        set -o history
                        CHIST=()
                        while IFS= read -r line; do
                            CHIST+=( "$line" )
                        done < <( history )
                        zenity --list --title "COMMAND HISTORY" --text "" --width=1000 --height=800 --column COMMAND "${CHIST[@]}"
                        ;;
                    "Search Something in history")
                        # Your code for searching something in history
                        key2="$(zenity --entry --title "Search a Command" --text "Please enter keyword:")"
                        HISTFILE=~/.bash_history
                        set -o history
                        SHIST=()
                        while IFS= read -r line; do
                            SHIST+=( "$line" )
                        done < <( history | grep -i $key2 | tail -50 )
                        zenity --list --title "COMMAND HISTORY" --text "" --width=1000 --height=800 --column COMMAND "${SHIST[@]}"
                        ;;
                    "Login History")
                        # Your code for Login History
                        N=$(zenity --entry --width=1000 --height=800 --title "Login History" --text "Enter no. of history you want:")
                        LHIST=()
                        while IFS= read -r line; do
                            LHIST+=( "$line" )
                        done < <( last -a | head -$N )
                        zenity --list --width=1000 --height=800 --title "Login History" --text "Login History of all the users is as follows:" --column "USER             DAY   DATE  TIME  STATUS" "${LHIST[@]}"
                        ;;
                    *)
                        break  # Go back to the main category selection
                        ;;
                esac
            done
            ;;
        "Other Activities")
            while true; do
                OTHER_ACTIVITIES_SELECTION="$(zenity --list --title "OTHER ACTIVITIES" --column Selection --column Functionality \
                    TRUE "Check System Temperature" \
                    FALSE "Display Calendar" \
                    --width=1000 --height=800 --radiolist --cancel-label "Back")"
                Stat=$?

                case "$OTHER_ACTIVITIES_SELECTION" in
                    "Check System Temperature")
                        # Function to check system temperature
                        check_system_temperature
                        zenity --info --width=1200 --height=700 --text "System Temperature:\n$TEMPERATURE_INFO"
                        ;;
                    "Display Calendar")
                        # Function to display calendar
                        zenity --calendar --title="Calendar"
                        ;;
                    *)
                        break  # Go back to the main category selection
                        ;;
                esac
            done
            ;;
		"ShutDown LAPTOP")
    	# Confirm the shutdown
    		zenity --question --width=1200 --height=700 --text "Are you sure you want to shut down your laptop?" --ok-label="Yes" --cancel-label="No"
    		RESPONSE=$?

    		if [ $RESPONSE -eq 0 ]; then
        	# Shutdown the laptop
        		zenity --info --width=1200 --height=700 --text "Shutting down your laptop..." --ok-label "OK" --no-wrap
        # Add any additional shutdown logic here, e.g., shutdown -h now
        		shutdown -h now
    		fi
    		;;	
		*)
            X1=1  # Quit button clicked or window closed
            ;;
    esac
done
