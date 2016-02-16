# ~/.bashrc

for file1 in *; do

    for file2 in *; do

        if [ "$file1" != "$file2" ]; then 

            if diff -q "$file1" "$file2" > /dev/null; then
                echo "files ($file1,$file2) are the same"
            fi

        fi
    done
done
