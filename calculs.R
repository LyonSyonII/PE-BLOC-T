source("plots.R")

# Ruta del fitxer CSV
csv <- "Dades.csv"

# Llegim el fitxer CSV
dades <- read.csv(csv)

mitjana_mida <- mean(dades$Mida)
summary(dades$Rati7z)

# Obtenim el model normal per a la mida RAR
mitjana_mida_rar <- mean(dades$MidaRar)
desviacio_mida_rar <- sd(dades$MidaRar)

# Obtenim el model normal per a la mida 7z
mitjana_mida_7z <- mean(dades$Mida7z)
desviacio_mida_7z <- sd(dades$Mida7z)

# Dibuixem un gràfic amb les i observem les mitjanes de mida
barplot(c(mitjana_mida, mitjana_mida_rar, mitjana_mida_7z)/1000000,
        names.arg = c("Sense comprimir", "Compressió RAR", "Compressió 7z"),
        ylim = c(0, 1.2),
        main = "Mitjana de mides",
        ylab = "Tamany (en MB)")

# Model mida RAR
model_mida_rar <- rnorm(1000, mitjana_mida_rar, desviacio_mida_rar)

# Model mida 7z
model_mida_7z <- rnorm(1000, mitjana_mida_7z, desviacio_mida_7z)

mitjana_rati_rar <- mean(dades$RatiRar)
mitjana_rati_7z <- mean(dades$Rati7z)

# Comparem els Q-Q dels dos tipus de rati, i observem que no segueixen la normalitat
par(mfrow = c(1, 2))

qqnorm(dades$RatiRar)
qqline(dades$RatiRar)

qqnorm(dades$Rati7z)
qqline(dades$Rati7z)



# Tots els fitxers
ratiDif <- dades$RatiRar-dades$Rati7z

qqnorm(ratiDif, main="Rati (RAR-7z)")
qqline(ratiDif)
summary(ratiDif)
boxplot_custom(
  fitxersText$RatiRar, fitxersText$Rati7z, 
  main="Boxplot ràtio de compressió", 
  ylab="Ràtio de compressió (mida final / mida inicial)",
  names=c("RAR", "7z")
)

# Nomes els fitxers de text
fitxersText <- dades[dades$Categoria == "TEXT",]
fitxersTxt <- fitxersText[fitxersText$Tipus == "TXT",]
fitxersHtml <- fitxersText[fitxersText$Tipus == "HTML",]

fitxersTextDif <- fitxersText$RatiRar - fitxersText$Rati7z
qqnorm(fitxersTextDif, main="Rati (RAR-7z)")
qqline(fitxersTextDif)
boxplot_custom(
  fitxersText$RatiRar, fitxersText$Rati7z, 
  main="Boxplot ràtio de compressió", 
  ylab="Ràtio de compressió (mida final / mida inicial)",
  names=c("RAR", "7z")
)

# Nomes els fitxers .txt
fitxersTxtDif <- fitxersTxt$RatiRar - fitxersTxt$Rati7z
qqnorm(fitxersTxtDif, main="Rati (RAR-7z)")
qqline(fitxersTxtDif)

# Nomes els fitxers HTML
fitxersHtmlDif <- fitxersHtml$RatiRar - fitxersHtml$Rati7z
qqnorm(fitxersHtmlDif, main="Rati (RAR-7z)")
qqline(fitxersHtmlDif)

# Boxplot
boxplot_custom(dades$RatiRar, dades$Rati7z, main="Boxplot ràtio de compressió", ylab="Ràtio de compressió (mida final / mida inicial)")

# Proves amb logaritme
ratiRarLog <- log(dades$RatiRar)
rati7zLog <- log(dades$Rati7z)
ratiLogDif <- ratiRarLog-rati7zLog
qqnorm(ratiLogDif, main="Rati log(RAR-7z)")
qqline(ratiLogDif)

# t.test dels les ràtios
# Com que son mostres aparellades, 
t.test(log(dades$RatiRar), log(dades$Rati7z), paired=TRUE)


# Provarem amb el tipus de fitxer "TEXT"
par(mfrow = c(1, 2))

fitxersText <- dades[dades$Tipus == "TXT",]

qqnorm(fitxersText$RatiRar,
       main = "Rati RAR")
qqline(fitxersText$RatiRar)

qqnorm(fitxersText$Rati7z,
       main = "Rati 7z")
qqline(fitxersText$Rati7z)

# Obtenim tots els tipus de dades disponibles (using a breakpoint)
tipus_dades <- unique(dades$Tipus)
par(mfrow = c(1, 2))
for (tipus in tipus_dades) {
  fitxers <- dades[dades$Tipus == tipus,]
  qqnorm(fitxers$RatiRar,
         main = paste("Rati RAR", tipus))
  qqline(fitxers$RatiRar)
  
  qqnorm(fitxers$Rati7z,
         main = paste("Rati 7z", tipus))
  qqline(fitxers$Rati7z)
}

# Summary de dades
summary(dades$RatiRar)
summary(dades$Rati7z)
summary(dades$RatiRar-dades$Rati7z)