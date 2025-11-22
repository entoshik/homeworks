library(readxl)
patients <- read_excel("/home/scripts/patients.xlsx")
print(str(patients$Возраст))
print(str(patients$глюкоза))
patients$Пол <- factor(tolower(patients$Пол), levels = c("м", "ж"))
patients$возраст_группа_2 <- ifelse(patients$Возраст <= 60, "Молодые", "Старшие")
summary(patients$глюкоза)
summary(patients$лейкоциты)
result <- aggregate(глюкоза ~ Пол, data = patients, FUN = mean)
result2 <- aggregate(лейкоциты~ Пол + возраст_группа_2 , 
                     data = patients, FUN = mean)
aggregate(глюкоза ~ Пол + возраст_группа_2, 
          data = patients,  mean)
aggregate(глюкоза ~ Пол + возраст_группа_2, 
          data = patients,  sd)
aggregate(глюкоза ~ Пол + возраст_группа_2, 
          data = patients,  length)
boxplot( глюкоза ~ Пол, data = patients,main = "Распределение глюкозы по полу")

#H₀: Средние значения лейкоцитов у мужчин и женщин одинаковы.
#H₁: Средние значения различаются.
# p-value = 0.09424 => При уровне значимости 5% H0 не отвергается
t.test(лейкоциты ~ Пол, data = patients)

patients_task <- patients
patients_task$глюкоза[c(3, 15, 45)] <- NA
sum(is.na(patients_task))
which(is.na(patients_task$глюкоза))
patients_no_na <- na.omit(patients_task)
dim(patients_no_na)
dim((patients_task))
aggregate(лейкоциты ~ Пол, data = patients_task,
          FUN = mean, na.rm = TRUE)
aggregate(лейкоциты ~ Пол, data = patients_no_na,
          FUN = mean)
patients_task$гемоглобин[is.na(patients_task$гемоглобин)] <- median(patients$гемоглобин, na.rm = TRUE)
final_result <- aggregate(гемоглобин ~ Пол + возраст_группа_2, 
                          data = patients_task, mean)

names(final_result) <- c("Пол", "возраст_группа_2",
                         "Средний_гемоглобин")
final_result$стандартное_отклонение_гемоглобин <- aggregate(
  гемоглобин ~ Пол + возраст_группа_2, 
  data = patients_task, sd)$гемоглобин
output_file <- "/home/results/анализ_гемоглобина.csv"
write.csv(final_result, output_file, row.names = FALSE)

print(paste("Файл сохранен как:", output_file))
print("Готово!")