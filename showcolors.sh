# Convenience script for seeing the colors your terminal supports
for i in {0..256}; 
    do echo -en "\033[38;5;${i}m${i}\t";
done
echo ""
