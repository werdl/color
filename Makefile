push:
	v fmt -w .
	git add .
	git commit -m "$(m)"
	git push