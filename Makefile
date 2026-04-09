Final.html: Final.Rmd code/03_RenderReport.R .analysis
	Rscript code/03_RenderReport.R
	
.analysis: code/01_Table.R code/02_Graph1.R data/F1_Dataset.xlsx
	Rscript code/01_Table.R && Rscript code/02_Graph1.R && touch .analysis
	
.PHONY: clean
clean:
	rm -f output/* && rm -f Final.html && rm -f .analysis
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"