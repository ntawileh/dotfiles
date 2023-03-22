function fish_mode_prompt
	if [ $status -ne 0 ]
		set_color 'red'
		echo ":( "
	else	
		set_color 'green'
		echo ":) "
		set_color normal
	end	
end
