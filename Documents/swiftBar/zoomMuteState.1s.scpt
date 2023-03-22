#!/usr/bin/osascript

# <bitbar.title>zoomMuteState</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>nickjvturner</bitbar.author>
# <bitbar.author.github>nickjvturner</bitbar.author.github>
# <bitbar.desc>Zoom Mute State</bitbar.desc>
# <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>Applescript</bitbar.dependencies>
# <bitbar.abouturl>http://url-to-about.com/</bitbar.abouturl>

# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>false</swiftbar.hideSwiftBar>

property btnTitle : "Mute audio"

if application "zoom.us" is running then
	tell application "System Events"
		tell application process "zoom.us"
			if exists (menu bar item "Meeting" of menu bar 1) then
				if exists (menu item btnTitle of menu 1 of menu bar item "Meeting" of menu bar 1) then
					set returnValue to "LIVE :mic:"
					set formatValue to "size=18 color=#ff8800 sfcolor=#ff3333 href=zoommtg://open"
				else
					set returnValue to "MUTED :mic:"
					set formatValue to "color=#0033ff sfcolor=#0033ff href=zoommtg://open"
				end if
			else
				set returnValue to ""
				set formatValue to ""
			end if	
		end tell
	end tell
else
	set returnValue to ""
	set formatValue to ""
end if

return returnValue & "| " & formatValue & " 
---
zoomMuteState"
