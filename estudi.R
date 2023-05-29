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
categories <- c(
  "AUDIO"=dades[dades$Categoria == "AUDIO",],
  "VIDEO"=dades[dades$Categoria == "VIDEO",],
  "IMAGE"=dades[dades$Categoria == "IMAGE",],
  "TEXT"=dades[dades$Categoria == "TEXT",]
)

png("mitjanamida_barplot.png", width = 500, height = 500)
barplot(
  c(mean(dades$Mida), mean(dades$MidaRar), mean(dades$Mida7z))/1000000,
  names.arg = c("Sense comprimir", "RAR", "7z"),
  ylim = c(0, 1.2),
  main = "Mitjana de mides",
  ylab = "Tamany (en MB)"
)
dev.off()

boxplot_custom(
  dades$RatiRar, dades$Rati7z,
  main = "Boxplot de ràtios",
  ylab = "Ràtio de compressió (mida final / mida inicial)",
  names = c("RAR", "7z"),
  save2png = TRUE
)

boxplot_custom(
  categories$AUDIO.RatiRar, categories$AUDIO.Rati7z,
  main = "Boxplot de ràtios d'arxius d'ÀUDIO",
  ylab = "Ràtio de compressió (mida final / mida inicial)",
  names = c("RAR", "7z"),
  save2png = TRUE,
  notch = FALSE
)

boxplot_custom(
  categories$VIDEO.RatiRar, categories$VIDEO.Rati7z,
  main = "Boxplot de ràtios d'arxius de VÍDEO",
  ylab = "Ràtio de compressió (mida final / mida inicial)",
  names = c("RAR", "7z"),
  save2png = TRUE
)

boxplot_custom(
  categories$IMAGE.RatiRar, categories$IMAGE.Rati7z,
  main = "Boxplot de ràtios d'arxius d'IMATGE",
  ylab = "Ràtio de compressió (mida final / mida inicial)",
  names = c("RAR", "7z"),
  save2png = TRUE,
  notch = FALSE
)

boxplot_custom(
  categories$TEXT.RatiRar, categories$TEXT.Rati7z,
  main = "Boxplot de ràtios d'arxius de TEXT",
  ylab = "Ràtio de compressió (mida final / mida inicial)",
  names = c("RAR", "7z"),
  save2png = TRUE,
  notch = FALSE
)

png("mitjanamida_audio_barplot.png", width = 500, height = 500)
barplot(
  c(mean(categories$AUDIO.Mida), mean(categories$AUDIO.MidaRar), mean(categories$AUDIO.Mida7z))/1000000,
  names.arg = c("Sense comprimir", "RAR", "7z"),
  ylim = c(0, 3.5),
  main = "Mitjana de mides d'arxius AUDIO",
  ylab = "Tamany (en MB)"
)
dev.off()

png("mitjanamida_video_barplot.png", width = 500, height = 500)
barplot(
  c(mean(categories$VIDEO.Mida), mean(categories$VIDEO.MidaRar), mean(categories$VIDEO.Mida7z))/1000000,
  names.arg = c("Sense comprimir", "RAR", "7z"),
  ylim = c(0, 4.3),
  main = "Mitjana de mides d'arxius VIDEO",
  ylab = "Tamany (en MB)"
)
dev.off()

png("mitjanamida_image_barplot.png", width = 500, height = 500)
barplot(
  c(mean(categories$IMAGE.Mida), mean(categories$IMAGE.MidaRar), mean(categories$IMAGE.Mida7z))/1000000,
  names.arg = c("Sense comprimir", "RAR", "7z"),
  ylim = c(0, 1.8),
  main = "Mitjana de mides d'arxius IMATGE",
  ylab = "Tamany (en MB)"
)
dev.off()

png("mitjanamida_text_barplot.png", width = 500, height = 500)
barplot(
  c(mean(categories$TEXT.Mida), mean(categories$TEXT.MidaRar), mean(categories$TEXT.Mida7z))/1000,
  names.arg = c("Sense comprimir", "RAR", "7z"),
  ylim = c(0, 50),
  main = "Mitjana de mides d'arxius TEXT",
  ylab = "Tamany (en KB)"
)
dev.off()
