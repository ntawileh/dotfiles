local rgb_match = "rgb%(%s*(%d%d[%d]*)%s*,%s*(%d%d[%d]*)%s*,%s*(%d%d[%d]*)%s*%)"
local test = "RGB( 255 , 245 , 235 )"

for r, g, b in test:lower():gmatch(rgb_match) do
	print(r, g, b)
end

