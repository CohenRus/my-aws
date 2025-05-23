#!/bin/zsh

addFile ()
{
    # check to see if a valid file or directory
    if [[ -d "$1" ]] || [[ -f "$1" ]]; then
        fullPath=$(realpath "$1") 
        # check if already in selected
        if grep -qFx "$fullPath" "$SELECTED_PATH"; then
            echo "$1" already in selected files list
            return
        fi

        # check if its a file to be ignored

        # add to selected
        print "$fullPath" >> "$SELECTED_PATH"
        echo /"$1" added to selected files
    else
        echo "invalid file or directory path"
        return
    fi
}

removeFile ()
{
    path_to_remove="$1"

    # check if file exists
    if grep -qFx "$path_to_remove" "$SELECTED_PATH"; then
        # remove it, write the new into a temp file
        grep -vFx "$path_to_remove" "$SELECTED_PATH" > "$TEMP_PATH"
        # copy temp file into users selected file
        cp "$TEMP_PATH" "$SELECTED_PATH"
        echo "$path_to_remove" removed from selected files
        return
    else
        echo "$path_to_remove" failed to be successfully removed
        echo "please check that the filepath you enter was correct"
        echo "you can check selected files using \"myaws list\"" 
    fi

}