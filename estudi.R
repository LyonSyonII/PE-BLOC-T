source("plots.R")

# Ruta del fitxer CSV
csv <- "Dades.csv"
# Llegim el fitxer CSV
dades <- read.csv(csv)

# Extreem dades
ratiRar <- dades$RatiRar
rati7z <- dades$Rati7z
ratiDif <- ratiRar-rati7z

ratiRarLog <- log(ratiRar)
rati7zLog <- log(rati7z)
ratiDifLog <- log(ratiDif)

# Analitzem les dades
summary(ratiRar)
summary(rati7z)
summary(ratiDif) # COM QUE ES POSITIU, 7Z GUANYA

qqnorm_custom(ratiRar, "Rati RAR")
qqnorm_custom(rati7z, "Rati 7z")
qqnorm_custom(ratiDif, "Rati (RAR-7z)")


