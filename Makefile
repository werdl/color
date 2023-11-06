run:
	v fmt -w src
	v run .

push:
	v fmt -w src
	git add .
	git commit -m "$(m)"
	git push