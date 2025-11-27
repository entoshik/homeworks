import numpy as np
import pandas as pd


# Результаты масс-спектрометрии
mass_spec_results = pd.DataFrame({
    'sample_id': ['Sample_1', 'Sample_2', 'Sample_3', 'Sample_4', 'Sample_7'],
    'total_proteins': [2450, 2310, 2540, 2480, 2600],
    'unique_peptides': [15200, 14800, 15600, 15400, 16200],
    'contamination_level': [0.02, 0.05, 0.03, 0.01, 0.04]
})

# Данные о качестве
quality_metrics = pd.DataFrame({
    'sample_id': ['Sample_2', 'Sample_3', 'Sample_4', 'Sample_5', 'Sample_8'],
    'rin_score': [8.5, 7.2, 9.1, 6.8, 8.9],
    'pcr_duplication': [0.12, 0.18, 0.09, 0.25, 0.11],
    'mapping_rate': [0.95, 0.87, 0.96, 0.82, 0.94]
})

df_mass = pd.DataFrame(mass_spec_results)
df_metrics = pd.DataFrame(quality_metrics)
df_mass.to_csv('./input/mass_spec_data.csv', index=False)
df_metrics.to_csv('./input/quality_metrics_data.csv', index=False)

df_mass = pd.read_csv('./input/mass_spec_data.csv')
df_metrics = pd.read_csv('./input/quality_metrics_data.csv')

inner_join = pd.merge(df_mass, df_metrics, on='sample_id', how='inner')
print("Inner Join успешно выполнен и сохранен в папку output!")
print(inner_join)
inner_join.to_csv('./output/inner_join.csv', index=False)


left_join = pd.merge(df_mass, df_metrics, on='sample_id', how='left')
print("Left Join успешно выполнен и сохранен в папку output!")
print(left_join)
left_join.to_csv('./output/left_join.csv', index=False)


right_join = pd.merge(df_mass, df_metrics, on='sample_id', how='right')
print("Right Join успешно выполнен и сохранен в папку output!")
print(right_join)
right_join.to_csv('./output/right_join.csv', index=False)


outer_join = pd.merge(df_mass, df_metrics, on='sample_id', how='outer')
print("Outer Join успешно выполнен и сохранен в папку output!")
print(outer_join)
outer_join.to_csv('./output/outer_join.csv', index=False)