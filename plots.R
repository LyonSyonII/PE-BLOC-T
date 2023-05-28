boxplot_custom <- function(..., ylab, main, names = c()) {
  boxplot(
    ...,
    lwd = 2,
    col = rgb(1, 0, 0, alpha = 0.4),
    ylab = ylab,
    main = main,
    border = "black",
    outpch = 25,
    outbg = "green",
    whiskcol = "blue",
    whisklty = 2,
    lty = 1,
    notch = TRUE,
    names = names
  )
  
  data <- list(...)
  
  i <- 0
  for (d in data) {
    points(
      runif(length(d), 0.8+i, 1.2+i),
      d,
      col = "brown",
      pch = 18
    )
    i <- i + 1
  }
}

qqnorm_custom <- function(data, main) {
  qqnorm(data, main=main)
  qqline(data)
}





# boxplot(
#   fitxersHtml$RatiRar,
#   fitxersHtml$Rati7z,
#   lwd = 2,
#   col = rgb(1, 0, 0, alpha = 0.4),
#   ylab = "Ràtio de compressió (mida final / mida inicial)",
#   main = "Boxplot ràtio de compressió",
#   border = "black",
#   outpch = 25,
#   outbg = "green",
#   whiskcol = "blue",
#   whisklty = 2,
#   lty = 1,
#   notch = TRUE,
#   names=names
# )
# points(
#   runif(length(fitxersHtml$RatiRar), 0.8, 1.2),
#   fitxersHtml$RatiRar,
#   col = "brown",
#   pch = 18
# )
# points(
#   runif(length(fitxersHtml$Rati7z), 1.8, 2.2),
#   fitxersHtml$Rati7z,
#   col = "brown",
#   pch = 18
# )