all: build/example.js

JAVA=java
#CLOSURE_VERSION=20170521
CLOSURE_VERSION=20170626
CLOSURE=$(JAVA) -jar closure-compiler-v$(CLOSURE_VERSION).jar
cc_closure_level = ADVANCED
cc_closure_warnings = VERBOSE
cc_closure_args = \
	--language_in ECMASCRIPT6_STRICT \
	--language_out ECMASCRIPT5_STRICT \
	--dependency_mode LOOSE \
	--module_resolution NODE \
	--compilation_level $(cc_closure_level) \
	--warning_level $(cc_closure_warnings) \
 	--jscomp_warning=reportUnknownTypes \
	--rewrite_polyfills=false \
	--js_output_file $@ \
	--js *.js

build/example.js: closure-compiler *.js
	mkdir -p build
	$(CLOSURE) $(cc_closure_args)

closure-compiler: closure-compiler-v$(CLOSURE_VERSION).jar

closure-compiler-v$(CLOSURE_VERSION).jar:
	wget http://dl.google.com/closure-compiler/compiler-$(CLOSURE_VERSION).zip
	unzip compiler-$(CLOSURE_VERSION).zip closure-compiler-v$(CLOSURE_VERSION).jar
	rm compiler-$(CLOSURE_VERSION).zip

clean:
	rm -rf build
