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
ratiDifLog <- ratiRarLog-rati7zLog

# Analitzem les dades
summary(ratiRar)
summary(rati7z)
summary(ratiDif) # COM QUE ES POSITIU, 7Z GUANYA

qqnorm_custom(ratiRar, "Ràtio RAR")
qqnorm_custom(rati7z, "Ràtio 7z")
qqnorm_custom(ratiDif, "Ràtio (RAR-7z)")

qqnorm_custom(ratiRarLog, "Ràtio log(RAR)")
qqnorm_custom(rati7zLog, "Ràtio log(7z)")
qqnorm_custom(ratiDifLog, "Ràtio log(RAR-7z)")

boxplot_custom(
  ratiRar, 
  rati7z, 
  main="Boxplot ràtio de compressió", 
  ylab = "Ràtio de compressió (mida final / mida inicial)", 
  names=c("RAR", "7z")
)
boxplot_custom(
  ratiRarLog, 
  rati7zLog, 
  main="Boxplot logaritme de ràtio de compressió", 
  ylab = "Ràtio de compressió (mida final / mida inicial)", 
  names=c("log(RAR)", "log(7z)")
)
boxplot_custom(
  ratiDif,
  main="Boxplot diferències de ràtio de compressió", 
  ylab = "Ràtio de compressió (mida final / mida inicial)", 
  names=c("RAR-7z")
)
boxplot_custom(
  ratiDifLog,
  main="Boxplot diferència dels logaritmes de ràtio de compressió", 
  ylab = "Ràtio de compressió (mida final / mida inicial)", 
  names=c("log(RAR)-log(7z)")
)

# Tests
t.test(ratiRar, rati7z, paired = TRUE)
t.test(ratiRarLog, rati7zLog, paired = TRUE)

# Grafics curiositat
barplot(
  c(mean(dades$Mida), mean(dades$MidaRar), mean(dades$Mida7z))/1000000,
  names.arg = c("Sense comprimir", "Compressió RAR", "Compressió 7z"),
  ylim = c(0, 1.2),
  main = "Mitjana de mides",
  ylab = "Tamany (en MB)"
)
