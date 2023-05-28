# Ruta del fitxer CSV
csv <- "Dades.csv"

# Llegim el fitxer CSV
dades <- read.csv(csv)

mitjana_mida <- mean(dades$Mida)

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