NEW_FILE_NAME=$1

if [[ -z $NEW_FILE_NAME ]]
then
    echo `date`" - Missing mandatory new resume filename. "
    exit 1
elif [[ ! -f $NEW_FILE_NAME ]]
then
    echo `date`" - File doesn't exist. "
    exit 1
fi

# read last update date specifics for archive creation
read -r YEAR MONTH DATE < ./latest/last_update.txt
# echo $YEAR.$MONTH.$DATE

# create archive directory if not exists
mkdir -p ./archive/$YEAR && mkdir -p ./archive/$YEAR/$MONTH

# make archive name for old resume
ARCHIVE="Ankur_Chattopadhyay-${DATE}.pdf"
echo $ARCHIVE

# archive latest copy to archive with archived name
cp ./latest/Ankur_Chattopadhyay.pdf ./archive/$YEAR/$MONTH/$ARCHIVE

# rename new file and place in latest/ directory
mv ./$NEW_FILE_NAME ./latest/Ankur_Chattopadhyay.pdf

# update last_update date
date +"%Y %b %d" > latest/last_update.txt

# stage latest and archive folder modifications to git
git add latest/ archive/

# commit and push
TODAY=`date +%D`
git commit -m "feat: update resume on $TODAY"
git push

echo "Resume updated"

exit 0