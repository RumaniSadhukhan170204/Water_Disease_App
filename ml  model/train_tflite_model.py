# train_tflite_model.py
import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler

# Load data
df = pd.read_csv('Water Quality Testing.csv')
df.columns = [col.strip().lower().replace(' ', '_') for col in df.columns]
print("Columns:", df.columns.tolist())

# Assign disease using updated column names
def assign_disease(row):
    if row['turbidity_(ntu)'] > 5 and row['ph'] < 6.5:
        return 'Cholera Risk'
    elif row['conductivity_(µs/cm)'] > 1200 and row['dissolved_oxygen_(mg/l)'] < 5:
        return 'Typhoid Risk'
    elif row['dissolved_oxygen_(mg/l)'] < 3.5:
        return 'Dysentery Risk'
    elif row['ph'] < 6.0 or row['ph'] > 9.0:
        return 'Hepatitis A Risk'
    else:
        return 'Safe'

df['disease'] = df.apply(assign_disease, axis=1)

# Encode labels
le = LabelEncoder()
df['label'] = le.fit_transform(df['disease'])

# Save labels to file
with open('labels.txt', 'w') as f:
    for label in le.classes_:
        f.write(f"{label}\n")

# Features and scaling
X = df[['ph', 'turbidity_(ntu)', 'dissolved_oxygen_(mg/l)', 'conductivity_(µs/cm)']]
y = df['label']
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, stratify=y, test_size=0.2, random_state=42)

# TensorFlow model
model = tf.keras.models.Sequential([
    tf.keras.layers.Input(shape=(4,)),
    tf.keras.layers.Dense(16, activation='relu'),
    tf.keras.layers.Dense(8, activation='relu'),
    tf.keras.layers.Dense(len(le.classes_), activation='softmax')
])
model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
model.fit(X_train, y_train, epochs=50, batch_size=8, verbose=1)

# Export to TFLite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()
with open('model.tflite', 'wb') as f:
    f.write(tflite_model)

