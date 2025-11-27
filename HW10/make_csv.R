library(dplyr)

sample_metadata <- read.csv("./data/sample_metadata.csv")
mass_spec_results <- read.csv("./data/mass_spec_results.csv") 

anti_left_join_result <- anti_join(sample_metadata, mass_spec_results, by = "sample_id")
print(anti_left_join_result)
print('____________________________________________________________')
write.csv(anti_left_join_result, "./data/anti_left_join_result.csv", row.names = FALSE)

anti_right_join_result <- anti_join(mass_spec_results,sample_metadata, by = "sample_id")
print(anti_right_join_result)
print('____________________________________________________________')
write.csv(anti_right_join_result, "./data/anti_right_join_result.csv", row.names = FALSE)

anti_outer_join_result <-  bind_rows(anti_left_join_result, anti_right_join_result)
print(anti_outer_join_result)
write.csv(anti_outer_join_result, "./data/aanti_outer_join_result.csv", row.names = FALSE)
