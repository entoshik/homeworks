# Задание 10: Получите информацию о 10 белках разной длины. 
# Постройте в R столбчатую диаграмму (barplot), отображающую длину каждого белка.

if (!require("httr")) install.packages("httr", repos = "http://cran.us.r-project.org")
if (!require("jsonlite")) install.packages("jsonlite", repos = "http://cran.us.r-project.org")

library(httr)
library(jsonlite)

get_protein_info <- function(accession) {
  url <- paste0("https://www.ebi.ac.uk/proteins/api/proteins/", accession)
  
  response <- GET(url, accept("application/json"))
  
  if (status_code(response) == 200) {
    data <- content(response, as = "parsed")
    
    protein_name <- ifelse(
      !is.null(data$protein$recommendedName$fullName$value),
      data$protein$recommendedName$fullName$value,
      accession
    )
    
    length <- ifelse(
      !is.null(data$sequence$length),
      data$sequence$length,
      0
    )
    
    return(list(
      accession = accession,
      name = protein_name,
      length = length
    ))
  }
  return(NULL)
}

protein_accessions <- c(
  "P01308", "P68871", "P01112", "P63104", "P62258",
  "P04637", "P10636", "P05067", "P02768", "P00738"
)

proteins_data <- list()

for (accession in protein_accessions) {
  protein_info <- get_protein_info(accession)
  if (!is.null(protein_info)) {
    proteins_data[[length(proteins_data) + 1]] <- protein_info
  }
}

proteins_df <- data.frame(
  Accession = sapply(proteins_data, function(x) x$accession),
  Name = sapply(proteins_data, function(x) substr(x$name, 1, 20)),
  Length = sapply(proteins_data, function(x) x$length)
)

proteins_df <- proteins_df[order(proteins_df$Length), ]

print(proteins_df)

png("proteins_barplot.png", width = 1200, height = 800, res = 120)

par(mar = c(10, 5, 4, 2))

barplot(
  proteins_df$Length,
  names.arg = proteins_df$Accession,
  las = 2,
  col = rainbow(nrow(proteins_df)),
  border = "black",
  main = "Длина последовательностей белков",
  xlab = "",
  ylab = "Длина (аминокислоты)",
  cex.names = 0.9,
  ylim = c(0, max(proteins_df$Length) * 1.1)
)

text(
  x = seq(0.7, by = 1.2, length.out = nrow(proteins_df)),
  y = proteins_df$Length + max(proteins_df$Length) * 0.02,
  labels = proteins_df$Length,
  cex = 0.8,
  col = "black"
)

legend(
  "topleft",
  legend = paste(proteins_df$Accession, "-", proteins_df$Name),
  fill = rainbow(nrow(proteins_df)),
  cex = 0.7
)

dev.off()

cat("График сохранен: proteins_barplot.png\n")

write.csv(proteins_df, "proteins_lengths.csv", row.names = FALSE)
cat("Данные сохранены: proteins_lengths.csv\n")

cat(sprintf("\nМин: %d а.к. (%s)\n", 
            min(proteins_df$Length), 
            proteins_df$Accession[which.min(proteins_df$Length)]))
cat(sprintf("Макс: %d а.к. (%s)\n", 
            max(proteins_df$Length), 
            proteins_df$Accession[which.max(proteins_df$Length)]))
cat(sprintf("Средняя: %.1f а.к.\n", mean(proteins_df$Length)))



#Сделайте запрос к Proteins API, чтобы получить данные о белке в формате FASTA. 
#Сохраните результат в файл с расширением .fasta
#!/usr/bin/env Rscript

# Задание 13: Сделайте запрос к Proteins API, чтобы получить данные о белке 
# в формате FASTA. Сохраните результат в файл с расширением .fasta

library(httr)

get_protein_fasta <- function(accession) {
  url <- paste0("https://www.ebi.ac.uk/proteins/api/proteins/", accession)
  
  response <- GET(url, accept("text/x-fasta"))
  
  if (status_code(response) == 200) {
    fasta_content <- content(response, as = "text", encoding = "UTF-8")
    return(fasta_content)
  }
  
  cat(sprintf("Ошибка: HTTP %d\n", status_code(response)))
  return(NULL)
}

save_fasta <- function(accession, output_file = NULL) {
  if (is.null(output_file)) {
    output_file <- paste0(accession, ".fasta")
  }
  
  cat(sprintf("Получение данных для %s...\n", accession))
  
  fasta_content <- get_protein_fasta(accession)
  
  if (!is.null(fasta_content)) {
    writeLines(fasta_content, output_file)
    
    cat(sprintf("Сохранено: %s\n\n", output_file))
    
    lines <- strsplit(fasta_content, "\n")[[1]]
    cat("Первые строки:\n")
    cat(paste(head(lines, 10), collapse = "\n"), "\n")
    if (length(lines) > 10) {
      cat(sprintf("... еще %d строк\n", length(lines) - 10))
    }
    
    sequence_lines <- lines[-1]
    sequence <- paste(sequence_lines, collapse = "")
    length <- nchar(sequence)
    
    cat(sprintf("\nДлина: %d аминокислот\n", length))
    
    return(TRUE)
  }
  
  return(FALSE)
}

proteins <- list(
  list(accession = "P04637", name = "p53"),
  list(accession = "P05067", name = "APP"),
  list(accession = "P10636", name = "Tau")
)

for (protein in proteins) {
  cat(sprintf("%s (%s)\n", protein$accession, protein$name))
  save_fasta(protein$accession)
  cat("\n")
}

cat("Готово!\n")

cat("\nДемонстрация форматов:\n")

accession <- "P04637"

cat("1. JSON format:\n")
response_json <- GET(
  paste0("https://www.ebi.ac.uk/proteins/api/proteins/", accession),
  accept("application/json")
)
cat(sprintf("   Статус: %d\n", status_code(response_json)))
cat(sprintf("   Content-Type: %s\n\n", headers(response_json)$`content-type`))

cat("2. FASTA format:\n")
response_fasta <- GET(
  paste0("https://www.ebi.ac.uk/proteins/api/proteins/", accession),
  accept("text/x-fasta")
)
cat(sprintf("   Статус: %d\n", status_code(response_fasta)))
cat(sprintf("   Content-Type: %s\n", headers(response_fasta)$`content-type`))

