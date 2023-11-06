run:
	v fmt -w src
	v run .

push:
	v fmt -w .
	git add .
	git commit -m "$(m)"
	git push