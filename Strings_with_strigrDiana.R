#Strings

library(tidyverse)
library(stringr)



#Determinar Coincidencias
#########################


#str_detect(). Retorna un vector logico

x <- c("apple", "banana", "pear")
x
str_detect(x, "e")


#Usemos el vector words.

words
length(words)

str_detect(words, "^t")

sum(str_detect(words, "^t"))

mean(str_detect(words, "[aeiou]$"))


#Ejemplo 1

#Encontrar todas las palabras que NO contienen vocales

#Manera 2
no_vowels_1 <- !str_detect(words, "[aeiou]")

#Manera 2
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")


identical(no_vowels_1, no_vowels_2)
#Aqui comprobamos que las condiciones son las mismas




#Ejemplo 2
str_detect(words, "x$")

words[str_detect(words, "x$")]



#Ejemplo 3
#Podemos filtrar en un data frame

df <- tibble(
  word = words,
  i = seq_along(word)
)

df
df %>%
  filter(str_detect(words, "x$"))



#Otra funcion str_count()

#Ejemplo 1
x <- c("apple", "banana", "pear")
str_count(x, "a")


#Ejemplo 2
str_count("abababa", "aba")


#Ejemplo 3
df %>%
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )





####Extract Matches
###################

#Vamos a manipular el vector sentences

sentences

length(sentences)
head(sentences)


colors <- c(
  " red ", " orange ", " yellow ", " green ", " blue ", " purple ", " brown "
)
color_match <- str_c(colors, collapse = "|")
color_match


#podemos seleccionar las oraciones que contienen un color
#Luego podemos extraer el color para saber cual es

has_color <- str_subset(sentences, color_match)
length(has_color)
head(has_color)


matches <- str_extract(has_color, color_match)
matches
head(matches)
#Aqui vemos cuales son los colores que coinciden,

#str_extract() solo extrae el primer match.
#Selecciones las oraciones que tienen mas de un color



sum(str_count(sentences, color_match) > 1)
more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)

#Cuales son los colores que esten en more

str_extract(more, color_match)

#Solo extrae la primera coincidencia

str_extract_all(more, color_match)


#Si usamos simplify = TRUE tendremos una matrix con todas las coincidencias

str_extract_all(more, color_match, simplify = TRUE)



#Replacing Matches
##################


#Ejemplo 1
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")

#Note que reemplaza solo el primer match

str_replace_all(x, "[aeiou]", "-")


#Ejemplo 2
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

#Podemos realizar multiples reemplazos


#Ejemplo 3
sentences %>%
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>%
  head(5)



#Splitting
#############
#str_split() para dividir una cadena en varias partes


#Ejemplo 1
sentences %>%
  head(5) %>%


  str_split(" ", simplify = TRUE)

#Las esta dividiendo en cada espacio


#Ejemplo 2
x <- c("AACXX", "BCOY")
str_split(x,"C")


#Ejemplo 3
"a|b|c|d" %>%
  str_split("\\|")


#Ejemplo 4
fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)


