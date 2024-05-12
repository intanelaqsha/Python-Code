import pandas as pd

# Membaca file CSV
df_premium = pd.read_csv('file_premium.csv')
df_regular = pd.read_csv('file_regular.csv')


# Menyaring kolom yang relevan
relevant_cols = ['user_id', 'clip_id', 'gamesession_Id', 'event_name', 'game_name', 'duration', 'created_at', 'join_at']
df_premium = df_premium[relevant_cols]
df_regular = df_regular[relevant_cols]

# Membedakan pengguna premium dan regular
df_premium.loc[:, 'user_type'] = 'Premium'
df_regular.loc[:, 'user_type'] = 'Regular'

# Menggabungkan kedua data frame
df_combined = pd.concat([df_premium, df_regular])
df_combined.to_csv('COMBINE.csv', index=False)

# Menghitung durasi rata-rata klip untuk setiap jenis pengguna
avg_duration = df_combined.groupby('user_type')['duration'].mean()
print(avg_duration)

# Mengubah kolom created_at dan join_at menjadi tipe datetime
df_combined['created_at'] = pd.to_datetime(df_combined['created_at'])

# Menghitung jumlah klip yang dibuat per bulan
clips_per_month = df_combined.groupby([pd.Grouper(key='created_at', freq='M'), 'user_type']).size().unstack()

print(clips_per_month)

import matplotlib.pyplot as plt

# Plot data menggunakan Matplotlib
clips_per_month.plot(kind='bar')
plt.xlabel('Month')
plt.ylabel('Total Clips')
plt.title('Total Clips Created')


# Mengambil 7 karakter awal dari setiap label x
x_labels = [label[:9] for label in clips_per_month.index.strftime('%b %Y')]
plt.xticks(range(len(clips_per_month.index)), x_labels, rotation=45)  # Putar label x-axis agar lebih mudah dibaca

plt.legend(title='User Type')
plt.tight_layout()  # Mengatur layout agar tidak tumpang tindih

# Tampilkan plot
plt.show()

