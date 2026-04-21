To generate the final report, enter `make docker` in the terminal, 

## Report contents

The final report includes:
- an introduction describing the Formula 1 dataset and the analysis objectives
- a formatted table showing the top drivers by average finishing position
- a figure comparing starting position and finishing position for the top 5 drivers
- brief written descriptions of the table and figure

## Initial code description

`code/01_Table.R`

- reads the Formula 1 dataset from `data/F1_Dataset.xlsx`
- creates the required table showing the top drivers by average finishing position
- saves the table as `output/driver_table.csv`

`code/02_Graph1.R`

- reads the Formula 1 dataset from `data/F1_Dataset.xlsx`
- creates the required figure comparing starting position and finishing position for the top 5 drivers
- saves the figure as `output/top5_figure.png`

`code/03_RenderReport.R`

- renders `Final.Rmd`

`Final.Rmd`

- reads the saved table from `output/driver_table.csv`
- includes the saved figure from `output/top5_figure.png`
- contains the introduction, table description, and figure description for the final report

`Makefile`

- contains rules for building the report
- running `make` will create the table output, figure output, and render the final HTML report
- running `make install` will restore the package environment using `renv`
- running `make docker` will create the report in the mounted `Final_Report/` folder using Docker

`Dockerfile`

- defines the container environment used to run the project
- starts from a base R image and installs required system dependencies like pandoc
- copies the project files and renv configuration into the container including restoring the R package environment
- Makes the final report when `make docker` is run in terminal and saves it to the mounted `Final_Report/` folder
