# install.packages("readxl")
# install.packages("magick")
# install.packages("extrafont")

library(extrafont)
library(readxl)
library(magick)
library(tidyverse)
font_import()
loadfonts()
names <- read_excel("Name Cert (Responses).xlsx", sheet = 2)

Sys.setenv(PATH = paste(Sys.getenv("PATH"), "C:/Program Files/gs/gs10.01.2/bin", sep = ";"))

template <- image_read("Ministry of Health2.png")

for (i in 1:nrow(names)) {
  name <- as.character(names[i, 1])
  certificate <- image_annotate(template, name, size = 70, gravity = "center", font="Georgia"   )
  image_write(certificate, paste0( name, "_Certificate.png"))
}

png_files <- list.files(path = "C:/Users/bonfa/Downloads/Antibiogram cert/Antibiogram cert", pattern = "*.png", full.names = TRUE)
images <- lapply(png_files, image_read)
pdf_file <- image_join(images)
image_write(pdf_file, "output.pdf")
