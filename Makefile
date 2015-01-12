js: lib/**/*.coffee
	coffee -o js -c lib/
	cp -r lib/font/data js/font/data
	
browser: lib/**/*.coffee
	mkdir -p build/
	browserify \
		--standalone PDFDocument \
		--debug \
		--transform coffeeify \
		--extension .coffee \
		lib/document.coffee \
		| ./node_modules/.bin/exorcist build/pdfkit.js.map > build/pdfkit.js
		
browser-demo: js demo/browser.js
	browserify demo/browser.js > demo/bundle.js
	
docs: pdf-guide website browser-demo
	
pdf-guide:
	coffee docs/generate.coffee
	
website:
	mkdir -p docs/img
	coffee docs/generate_website.coffee
		
clean:
	rm -rf js build demo/bundle.js
