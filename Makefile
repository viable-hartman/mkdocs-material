# Copyright (c) 2016-2019 Martin Donath <martin.donath@squidfunk.com>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

all: lint clean | build test

# -----------------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------------

# Distribution files
material: $(shell find src) .babelrc tsconfig.json webpack.config.ts
	$(shell npm bin)/webpack --mode production

# -----------------------------------------------------------------------------
# Rules
# -----------------------------------------------------------------------------

# Build distribution files
build: material

# Clean distribution files
clean:
	rm -rf coverage material

# Lint source files
lint:
	$(shell npm bin)/tslint -p tsconfig.json "src/**/*.ts"
	#$(shell npm bin)/tslint -p tests/tsconfig.json "tests/**/*.ts"
	$(shell npm bin)/stylelint `find src/assets -name *.scss`

# Run Webpack and MkDocs in watch mode for local development server
start:
	$(shell npm bin)/webpack --watch

# Execute tests
test:
	$(shell npm bin)/karma start tests/karma.conf.ts --single-run

# Execute tests in watch mode
watch:
	$(shell npm bin)/karma start tests/karma.conf.ts

# -----------------------------------------------------------------------------

# Special targets
.PHONY: .FORCE build clean lint start test watch
.FORCE:
