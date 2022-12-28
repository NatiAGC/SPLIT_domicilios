library(stringr)
library(readxl)
library(dbplyr)
library(tidyverse)
library(writexl)

DENUNCIAS <- read.csv ("C:/Users/npvazquez/Downloads/SUACI_ao.csv")
DENUNCIAS <-DENUNCIAS %>%
  rename('UBI'="Ubicación")

DENUNCIAS <-DENUNCIAS %>%
  arrange(UBI, .by_group = FALSE)

DENUNCIAS$UBI <- gsub(" |\r\n|\n|\r|", "", DENUNCIAS$UBI)
DENUNCIAS$UBI <- gsub("\\.","", DENUNCIAS$UBI)

DENUNCIAS <-DENUNCIAS %>%
  separate(UBI, 
           into = c("Calle", "Altura"), 
           sep = "(?<=[A-Za-z])(?=[0-9])")


CARGAS <- read_xlsx("C:/Users/npvazquez/Downloads/Asignaciones011122.xlsx")
CARGAS <- CARGAS%>%
  select("Fecha iniciado AGC",	"N Denuncia",	"Dirección", 	"Prestación",
          "Descripción",	"DG",	"Antecedentes recientes",	"Criticidad",
          "Estado",	"DEN",	"Tkt hijo",	"Motivo del Ticket",	
          "SGO a la que fue planificada",	"Denegado / Derivado"	, "Observación",
          "Propuesta cierre por antecedentes",	"Tkt hijo para cumplir",
          "Speech",	"Coincide criterio",	"Estado de cierre efectivo",
         "Tkt hijo de cierre efectivo",	"Nuevo speech")

CARGAS <- CARGAS%>%
  filter( Estado == "Derivada")

CARGAS <- CARGAS%>%
  rename('UBI'="Dirección")

CARGAS <- CARGAS%>%
  arrange(UBI, .by_group = FALSE)


CARGAS$UBI <- gsub(" |\r\n|\n|\r|", "", CARGAS$UBI)
CARGAS$UBI <- gsub("\\.","", CARGAS$UBI)

CARGAS <- CARGAS %>%
  separate (UBI, 
           into = c("Calle", "Altura"), 
           sep = "(?<=[A-Za-z])(?=[0-9])")
  
  
write_xlsx(x=CARGAS,"C:/Users/npvazquez/Downloads/CARGAS.xlsx")
write_xlsx(x=DENUNCIAS, "C:/Users/npvazquez/Downloads/DENUNCIAS.xlsx")
  
  