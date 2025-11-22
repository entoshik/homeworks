motifs2 <- matrix(c(
  "a", "C", "g", "G", "T", "A", "A", "t", "t", "C", "a", "G",
  "t", "G", "G", "G", "C", "A", "A", "T", "t", "C", "C", "a",
  "A", "C", "G", "t", "t", "A", "A", "t", "t", "C", "G", "G",
  "T", "G", "C", "G", "G", "G", "A", "t", "t", "C", "C", "C",
  "t", "C", "G", "a", "A", "A", "A", "t", "t", "C", "a", "G",
  "A", "C", "G", "G", "C", "G", "A", "a", "t", "T", "C", "C",
  "T", "C", "G", "t", "G", "A", "A", "t", "t", "a", "C", "G",
  "t", "C", "G", "G", "G", "A", "A", "t", "t", "C", "a", "C",
  "A", "G", "G", "G", "T", "A", "A", "t", "t", "C", "C", "G",
  "t", "C", "G", "G", "A", "A", "A", "a", "t", "C", "a", "C"
), nrow = 10, byrow = TRUE)

motifs2 <- toupper(motifs2)

count_matrix <- apply(motifs2, 2, function(col) table(factor(col, levels = c("A", "C", "G", "T"))))

scoreMotifs <- function(x){
  counts <- table(factor(x, levels = c("A", "C", "G", "T")))
  counts / sum(counts)
}
profile <- apply(motifs2, 2, scoreMotifs)

getConsensus <- function(x){
  nucleotides <- c("A", "C", "G", "T")
  nucleotides[which.max(x)]
}
consensus <- apply(profile, 2, getConsensus)
consensus <- paste(consensus, collapse = "")
consensus
?barplot
barplot(scoreMotifs(motifs2[,5]), col = "skyblue", main = 'Частоты нуклеотидов в 5-ом столбце')
