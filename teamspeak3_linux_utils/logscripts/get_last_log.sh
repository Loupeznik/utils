#!/bin/bash
file=$(ls -tp logs/ | head -1)
echo "### Opening file logs/$file ###"
cat logs/$file
echo "### End of file ###"
