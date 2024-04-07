all: pipeline.svg fosdem2024.pdf

fosdem2024.pdf: fosdem2024.md
	pandoc $< -s -o $@ -t beamer --pdf-engine=tectonic

pipeline.svg: pipeline.dot
	dot $<  -o $@ -Tsvg
