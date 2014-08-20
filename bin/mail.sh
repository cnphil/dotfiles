#! /bin/bash

# I could also have used `ls -1 | wc -l` - faster, but also includes directories

GMAIL=`ls -l ~/Mail/gmail/inbox/new/ | grep ^- | wc -l`
NEWS=`ls -l ~/Mail/gmail/news/new/ | grep ^- | wc -l`
SOCIAL=`ls -l ~/Mail/gmail/social/new/ | grep ^- | wc -l`

TOTAL=$(($GMAIL+$NEWS+$SOCIAL))
echo $GMAIL/$TOTAL
