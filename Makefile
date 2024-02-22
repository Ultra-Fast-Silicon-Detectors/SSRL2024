SOURCES=$(shell find manuals/ -name "*.rmd")
TARGET = $(SOURCES:%.rmd=%.md)

%.md : %.rmd
	@echo $(TARGET)
	Rscript -e "rmarkdown::render('$<', output_format = 'all')"

default: $(TARGET)

clean:
	rm -rf $(TARGET)