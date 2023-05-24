# Canviem el format de 'time' a '0.000' en segons
export TIMEFORMAT="%3R"
# Canviem separador de decimals a punt
export LC_NUMERIC="en_US.UTF-8"

# Extraiem els arxius
7z x Arxius.7z.001

for CATEGORIA in ./Arxius/*; do
    for TIPUS in $CATEGORIA/*; do
        for ARXIU in $TIPUS/*; do
            echo "Comprimint $ARXIU";
            # Utilitzem 'stat' per obtenir la mida del fitxer original en bytes
            MIDA=$(stat --printf="%s" $ARXIU)
            
            # Comprimim l'arxiu amb 'rar' i mesurem el temps
            # Redirigim stdout a null (per amagar output de rar) i stderr a stdout per tenir el resultat de 'time'
            VELOCITAT_RAR=$( { time rar a tmp.rar $ARXIU > /dev/null; } 2>&1 );
            # Utilitzem 'stat' per obtenir la mida del fitxer comprimit en bytes
            MIDA_RAR=$(stat --printf="%s" tmp.rar);
            # Utilitzem 'bc' per calcular la divisio, 'bash' no suporta operacions decimals
            RATI_RAR=$(echo "scale=3; $MIDA_RAR/$MIDA" | bc);
            
            # Comprimim l'arxiu amb '7z' i mesurem el temps
            # Redirigim stdout a null (per amagar output de 7z) i stderr a stdout per tenir el resultat de 'time'
            VELOCITAT_7Z=$( { time 7z a tmp.7z $ARXIU > /dev/null; } 2>&1 );
            # Utilitzem 'stat' per obtenir la mida del fitxer comprimit en bytes
            MIDA_7Z=$(stat --printf="%s" tmp.7z);
            # Utilitzem 'bc' per calcular la divisio, 'bash' no suporta operacions decimals
            RATI_7Z=$(echo "scale=3; $MIDA_7Z/$MIDA" | bc);
            
            # Obtenim nom de l'arxiu
            A=$(basename $ARXIU);
            # Obtenim nom de la carpeta pare de l'arxiu (tipus)
            T=$(basename $TIPUS);
            # Obtenim nom de la carpeta pare del tipus (categoria)
            C=$(basename $CATEGORIA);
            # Imprimim resultat a l'arxiu de dades
            echo "$A,$C,$T,$MIDA,$MIDA_RAR,$RATI_RAR,$VELOCITAT_RAR,$MIDA_7Z,$RATI_7Z,$VELOCITAT_7Z" >> Dades.csv;

            # Eliminem arxius comprimits per preparar la seguent iteracio
            rm tmp.7z tmp.rar;
        done
    done
done

# Eliminem arxius
rm -r Arxius