function clr-hostkey
	sed -i "/^$argv/d" ~/.ssh/known_hosts
end
