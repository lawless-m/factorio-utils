using ZipFile

bstring = "H4sIAAAAAAAA/42R0WrDMAxFfyX0OYImg74Uf0vxbK0V2HImOWHD5N/ndKOsacn2FAjn5lzd+NSE5GxoTqYgZ8qEakphG9HsrCrG10B8hmjdhRih37VD0oolNuXDwEv7afbz3P4kNFrJQKwoGWXFdle29STori8Pt1xIZ9JMDtwFNcNQzTQhDJIm8usP7e+df7dclYzoaYyAodaQ6hxSwPvA0hS6/531cFV/i71Z3Ryjex5bjSH4PtbnsxV+VdxwPagONUYu8fKniT0uyMaW1fFN9ZvUPB8F8yjcnI7I/gvQdo5aWgIAAA=="

zipped = base64decode(bstring)
zippedIO = IOBuffer(zipped)
unzipped = read(ZlibInflateInputStream(zipped))
 [@printf "%c" c for c in unzipped]
 
 #=
 
 expands to this (though I added the  newlines)
 
 do local _={
	entities={
		 {name="assembling-machine-2",position={x=-3,y=0}}, 
		 {name="smart-inserter",position={x=-1,y=0},direction=6},
		 {name="logistic-chest-passive-provider",position={x=0,y=0}},
		 {name="assembling-machine-2",position={x=3,y=0}},
		 {name="medium-electric-pole",position={x=1,y=-1}},
		 {name="smart-inserter",position={x=1,y=0},direction=2},
		 {name="fast-inserter",position={x=-1,y=1},direction=2},
		 {name="logistic-chest-requester",position={x=0,y=1}},
		 {name="fast-inserter",position={x=1,y=1},direction=6}
	}
	,icons={{index=1,name="assembling-machine-2"},{index=2,name="assembling-machine-2"}}
	};
	return _;
	end

don't know what this is
	
602-element Array{
Void,1}:                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 ⋮                                                                                                                          
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 nothing                                                                                                                    
 =#
 