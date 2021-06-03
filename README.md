# Audit-OutlookArchiveSettings
This script was written to help audit client machines that have enabled local archiving.

I was looking for a way to audit if end users enabled archiving, if so, where was the file stored and how large is it, and when was it last accessed.

https://community.spiceworks.com/topic/2196768-powershell-script-find-pst-files-on-network

I found this source, and tweaked it slightly. The issue appears that the script only works when run under the users own context, and returns null data when run as an admin.

I havenot yet figured out a solution to this issue other than to create an open writeable file and push the script as a logon script.

Stay tuned for updates...
