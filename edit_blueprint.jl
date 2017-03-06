using ZipFile

bstring = "H4sIAAAAAAAA/42R0WrDMAxFfyX0OYImg74Uf0vxbK0V2HImOWHD5N/ndKOsacn2FAjn5lzd+NSE5GxoTqYgZ8qEakphG9HsrCrG10B8hmjdhRih37VD0oolNuXDwEv7afbz3P4kNFrJQKwoGWXFdle29STori8Pt1xIZ9JMDtwFNcNQzTQhDJIm8usP7e+df7dclYzoaYyAodaQ6hxSwPvA0hS6/531cFV/i71Z3Ryjex5bjSH4PtbnsxV+VdxwPagONUYu8fKniT0uyMaW1fFN9ZvUPB8F8yjcnI7I/gvQdo5aWgIAAA=="

zipped = base64decode(bstring)
zippedIO = IOBuffer(zipped)
unzipped = ZipFile.Reader(zipped).read()
print(unzipped)




