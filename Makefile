# This Makefile is used to convert markdown files to PDF or TeX using Pandoc.

# Makefile variables
PANDOC := pandoc -t latex --template=letter.latex

# Makefile targets

# Convert specific markdown file to PDF
pdf: $(patsubst %.md,%.pdf,$(filter %.md,$(MAKECMDGOALS))) ## Usage: make pdf <filename.md> - Converts a specific .md to .pdf

# Convert all markdown files to PDF, excluding README.md
all_pdf: $(patsubst %.md,%.pdf,$(filter-out README.md,$(wildcard *.md))) ## Converts all .md files in the directory to .pdf

# Convert specific markdown file to TeX
tex: $(patsubst %.md,%.tex,$(filter %.md,$(MAKECMDGOALS))) ## Usage: make tex <filename.md> - Converts a specific .md to .tex

# Convert all markdown to TeX, excluding README.md
all_tex: $(patsubst %.md,%.tex,$(filter-out README.md,$(wildcard *.md))) ## Converts all .md files in the directory to .tex

# Pattern rule to generate PDFs
%.pdf: %.md
	$(PANDOC) -o $@ $<

# Pattern rule to generate TeX files
%.tex: %.md
	$(PANDOC) -o $@ $<

# Ignore the argument after the target
%:
	@:

# Clean generated PDFs
clean_pdf: ## Removes all PDF files in the current directory
	rm -f *.pdf

# Clean generated TeX files
clean_tex: ## Removes all TeX files in the current directory
	rm -f *.tex

# Clean all generated files
clean: clean_pdf clean_tex ## Removes all PDF and TeX files in the current directory

# Help target to list available commands
help: ## Print out a list of Make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Mark non-file targets as .PHONY
.PHONY: all pdf all_pdf tex all_tex clean clean_pdf clean_tex help

# Set default goal to help
.DEFAULT_GOAL := help
