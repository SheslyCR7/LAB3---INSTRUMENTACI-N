# Instrumentación Biomédica y Biosensores 
 LABORATORIO - 3 Cálculo ambulatorio del índice pletismográfico quirúrgico (SPI)  

###  Integrantes
- Shesly Nicole Colorado - 5600756
- Santiago Mora - 5600775
- Daniel Herrera - 5600588
### Requisitos
Software:
- Arduino IDE
- MATLAB
```python
# Importamos las librerías necesarias:
#include <Wire.h>
#include "MAX30105.h"
```
Hardware:
- Biosensor óptico integrado MAX30102 
- ESP32
----
# 1. Introducción

La fotopletismografía (PPG) es una técnica óptica no invasiva que permite medir cambios en el volumen sanguíneo periférico mediante la interacción entre la luz y los tejidos biológicos [1].

A partir de esta señal es posible obtener parámetros fisiológicos como la frecuencia cardíaca y la amplitud del pulso, los cuales reflejan la actividad del sistema cardiovascular y del sistema nervioso autónomo [2].

El índice pletismográfico quirúrgico (SPI) es un parámetro derivado de la señal PPG que combina información del intervalo entre latidos y la amplitud del pulso, permitiendo estimar la respuesta fisiológica ante estímulos como el estrés o la nocicepción.

#  2. Objetivos
   ## 2.1 Objetivo general
   Desarrollar un sistema de medición continua del índice pletismográfico quirúrgico (SPI) en condiciones ambulatorias.
   ## 2.2 Objetivos específicos
   - Reconocer las características fundamentales de la onda de pulso a partir de las cuales se obtiene el SPI.
   - Construir un sistema que calcule el SPI en tiempo real y bajo condiciones ambulatorias.
   - Validar el funcionamiento del sistema desarrollado mediante un método que induzca una respuesta fisiológica similar a la que produce el dolor agudo.
   
# 3. Descripción general de la práctica

Se implementó un sistema de adquisición de señal PPG utilizando el sensor MAX30102 conectado a un Arduino. La señal fue procesada en MATLAB, donde se aplicó un algoritmo de detección de picos basado en el método del alpinista. A partir de esta información se calcularon variables fisiológicas y el SPI, evaluando su comportamiento bajo diferentes condiciones experimentales.
   
# 4. Seguridad en el laboratorio

- Se verificaron conexiones seguras entre el ESP32 y el sensor MAX30102, evitando cortocircuitos y asegurando un montaje estable en protoboard.
- Para el estímulo fisiológico se utilizó una bolsa de gel frío congelada en lugar de agua, reduciendo riesgos y permitiendo un control seguro del tiempo de exposición.
- Se supervisó al paciente durante la prueba y se evitó el contacto prolongado para prevenir molestias o lesiones.

------
# 5. Procedimiento experimental
- Montaje del sistema de adquisición
- Se conectó el sensor MAX30102 al Arduino mediante comunicación I2C para la adquisición de la señal PPG.
 <p align="center">
  <img src="https://github.com/user-attachments/assets/398e4e7b-26f6-42a2-b0d6-675c15f29b49" width="400">
 </p>
 <p align="center">
     Fig. 1. Montaje Implementado
    </p>

   ### 5.1 Conexión con ESP32
En esta práctica se utilizó un ESP32 junto con el sensor MAX30102 para adquirir la señal fotopletismográfica. En el código de Arduino IDE, la comunicación con el sensor se realizó por protocolo I2C mediante Wire.begin(21,22), y la transmisión de datos hacia MATLAB se hizo por puerto serial a 115200 baudios. Además, el sistema se configuró para trabajar a una frecuencia de muestreo de 100 Hz, adecuada para registrar la onda de pulso periférica y sus variaciones en el tiempo. La PPG es una técnica óptica no invasiva que permite medir cambios de volumen sanguíneo periférico y obtener información cardiovascular a partir de la señal registrada [1].

  ### 5.3 Verificación de la señal
La verificación de la señal consistió en comprobar que la salida del sistema presentara una forma de onda periódica compatible con una señal PPG. En el código del ESP32 se tomó la lectura del canal infrarrojo con getIR() y posteriormente se invirtió la señal para facilitar su visualización. Esta etapa fue importante porque la señal PPG contiene una componente pulsátil asociada al ciclo cardíaco y una componente lenta relacionada con otros fenómenos fisiológicos [1]. Por ello, antes del procesamiento en MATLAB se verificó que la señal mostrara pulsos repetitivos y una amplitud suficientemente estable para detectar eventos característicos como picos y valles [1], [2].
  ### 5.4 Captura de datos

La captura de datos se realizó en MATLAB, donde el programa recibió las muestras enviadas por el ESP32, las almacenó junto con su respectiva marca temporal y las representó en tiempo real en una gráfica. El script también permitió definir la duración de la toma y guardar la señal en un archivo .mat para su análisis posterior. Esta etapa fue necesaria porque el estudio del SPI requiere una señal continua y ordenada en el tiempo, a partir de la cual puedan calcularse variables como el intervalo entre pulsos y la amplitud del pulso [1].
  ### 5.5 Detección de picos y valles
Para la detección de picos se implementó en MATLAB una versión adaptada del método del alpinista descrito por Argüello-Prada [3]. Este algoritmo se basa en contar ascensos consecutivos de la señal y utilizar un umbral para decidir cuándo una subida corresponde a un pico real. En el código, además, se incluyó un período refractario de 0.3 s para evitar detectar varias veces el mismo latido. Después de identificar los picos, se buscaron los mínimos entre pulsos consecutivos para obtener también los valles. Esta estrategia permitió caracterizar cada pulso con sus dos puntos principales: máximo y mínimo [3].
  ### 5.6 Cálculo del SPI
  
  <p align="center">
  <img width="400" height="295" alt="image" src="https://github.com/user-attachments/assets/0f802563-062f-4003-9a82-58bd38d0d904" />
   </p>
   <p align="center">
     Fig. 2. Explicación del cálculo de SPI
    </p>
Una vez detectados los picos, se calculó el intervalo entre pulsos consecutivos (PPI) y la amplitud de la onda pletismográfica (PPGA), definida como la diferencia entre el pico y el valle asociado. Estas dos variables tienen fundamento fisiológico porque la PPG refleja cambios de volumen sanguíneo periférico, los cuales dependen tanto de la dinámica cardíaca como del tono vascular [1], [7]. En este trabajo, el SPI se estimó a partir de una combinación normalizada de PPI y PPGA, lo cual permitió obtener un índice relativo de cambio fisiológico a lo largo del experimento. Aunque esta implementación corresponde a una aproximación académica, conserva la idea de relacionar la amplitud del pulso y el intervalo entre latidos con la actividad autonómica y la respuesta fisiológica al estímulo [1], [6].
  ### 5.7 Protocolo experimental (CPT)
  
El protocolo experimental se planteó en tres etapas: reposo, aplicación del Cold Pressor Test (CPT) y recuperación. El CPT se utilizó como maniobra para inducir una respuesta fisiológica aguda semejante a la activación asociada al dolor o al estrés, permitiendo observar cambios en la señal PPG y en el SPI. Esta prueba se emplea ampliamente para estudiar reactividad cardiovascular y activación del sistema nervioso autónomo [4], [5]. Desde el punto de vista fisiológico, el estímulo frío genera respuestas autonómicas que modifican el tono vascular periférico y la dinámica hemodinámica, lo que justifica su uso en esta práctica como método de validación del sistema desarrollado [4], [5], [6].   

# 6. Fundamento teórico del SPI

El índice pletismográfico quirúrgico (SPI) se basa en la señal fotopletismográfica (PPG), una técnica óptica no invasiva que permite registrar cambios de volumen sanguíneo periférico [1]. Esta señal contiene información útil sobre el pulso cardíaco y sobre cambios en la perfusión periférica, por lo que puede emplearse para estudiar variaciones fisiológicas del sistema cardiovascular [1], [2].

El fundamento fisiológico del SPI está en que el sistema nervioso autónomo modifica tanto la frecuencia cardíaca como el tono vascular [6]. Cuando hay una respuesta de estrés o un estímulo como el Cold Pressor Test (CPT), pueden presentarse cambios en la amplitud del pulso y en el intervalo entre latidos, lo cual se refleja en la señal PPG [4], [5], [7].

En esta práctica, el SPI se estimó a partir de dos características principales de la señal:

```python
PPGA = Pico - Valle
```
donde PPGA es la amplitud del pulso, y
```python
PPI = t_pico(i) - t_pico(i-1)
```
donde PPI es el intervalo entre pulsos consecutivos.

Luego, ambas variables se normalizaron y se combinaron para obtener una estimación del SPI:

```python
SPI = 100 * (0.33 * PPI_norm + 0.67 * (1 - PPGA_norm))
```
De esta manera, el SPI permitió observar cambios relativos en el estado fisiológico del sujeto a lo largo del experimento, especialmente antes, durante y después del CPT [4], [5].

-----
# 7. Técnica Cold Pressor Test (CPT)

El Cold Pressor Test es una técnica utilizada para inducir una respuesta de estrés fisiológico mediante la exposición al frío. Este estímulo activa el sistema nervioso simpático, generando cambios en la frecuencia cardíaca y en la señal PPG [4][5].

<p align="center">
 <img width="282" height="179" alt="image" src="https://github.com/user-attachments/assets/a1045cbd-82ec-4ae5-9e56-4f063caf64c1" />
 <img width="282" height="179" alt="image" src="https://github.com/user-attachments/assets/27fc55ec-5aa0-41b4-b0ce-858f1c8a9bef" />
</p>
 <p align="center">
     Fig. 3. Fases e implementación de la tecnica CPT
    </p>

----

# 8. Código desarrollado
    
   ### 8.1 Código de captura
Se desarrolló un código en Arduino IDE para el ESP32 que adquiere la señal del sensor MAX30102 mediante comunicación I2C y la envía por puerto serial. La frecuencia de muestreo se fijó en 100 Hz, lo que permitió obtener una señal adecuada para su posterior procesamiento en MATLAB.

Fragmento de código en ESP32:

```python
#include <Wire.h>
#include "MAX30105.h"

MAX30105 sensor;

unsigned long lastSampleTime = 0;
const int sampleInterval = 10; // 100 Hz

void setup() {
  Serial.begin(115200);
  Wire.begin(21, 22);

  sensor.begin(Wire, I2C_SPEED_FAST);
  sensor.setup(60, 4, 2, 100, 411, 4096);
}

void loop() {
  if (millis() - lastSampleTime >= sampleInterval) {
    lastSampleTime = millis();
    long irValue = sensor.getIR();
    long inverted = 200000 - irValue;
    Serial.println(inverted);
  }
}
```
En MATLAB también se implementó el código de captura, encargado de recibir la señal serial, mostrarla en tiempo real y guardarla en un archivo .mat para su posterior análisis.

Fragmento de código en MATLAB:

```python
puerto = "COM13";
baudrate = 115200;

s = serialport(puerto, baudrate);
configureTerminator(s,"LF");
flush(s);

fs = 100;
senal = [];
tiempo = [];

while toc < duracion
    if s.NumBytesAvailable > 0
        dato = readline(s);
        valor = str2double(dato);

        if ~isnan(valor)
            t_actual = toc;
            senal(end+1) = valor;
            tiempo(end+1) = t_actual;
        end
    end
end
```

  ### 8.2 Código de detección de picos
  
Para detectar los latidos en la señal PPG se implementó en MATLAB una adaptación del método del alpinista, propuesto para detección de picos en señales fotopletismográficas [3]. El algoritmo cuenta ascensos consecutivos de la señal y usa un umbral para decidir cuándo se detecta un pico. Además, se incluyó un período refractario para evitar contar varias veces el mismo pulso [3].


Fragmento de código:

```python
num_upsteps = 0;
threshold = 4;
picos = [];

refractory = 0.3;
ultimo_pico = -inf;

for i = 2:length(senal)

    if senal(i) > senal(i-1)
        num_upsteps = num_upsteps + 1;

    else
        if num_upsteps >= threshold
            t_pico = tiempo(i-1);

            if (t_pico - ultimo_pico) > refractory
                picos(end+1) = i-1;
                ultimo_pico = t_pico;
                threshold = round(0.6*num_upsteps);
            end
        end

        num_upsteps = 0;
    end
end
```
Después de identificar los picos, también se buscaron los mínimos entre pulsos consecutivos para caracterizar la amplitud de cada onda

```python
minimos = [];

for k = 1:length(picos)-1
    segmento = senal(picos(k):picos(k+1));
    [valor,idx] = min(segmento);
    minimos(k) = picos(k) + idx - 1;
end
```

   
   ### 8.3 Código de cálculo del SPI
   
   
A partir de los picos y valles detectados, el programa calculó dos variables principales: el intervalo entre pulsos consecutivos (PPI) y la amplitud del pulso (PPGA). Estas variables tienen sentido fisiológico porque la señal PPG refleja cambios de perfusión periférica y de dinámica cardiovascular [1], [7].

Fragmento de código:

```python

RR = diff(tiempo(picos));
HR = 60 ./ RR;

PPGA = senal(picos(1:end-1)) - senal(minimos);
PPI = RR;

PPGA_norm = PPGA / max(PPGA);
PPI_norm = PPI / max(PPI);
```
Luego, ambas variables se combinaron para obtener una estimación académica del SPI, con base en la relación entre amplitud del pulso, intervalo entre latidos y respuesta autonómica [1], [6].

```python
SPI = 100 * (0.33 * PPI_norm + 0.67 * (1 - PPGA_norm));
```

  ### 8.4 Código de evolución temporal del SPI

Finalmente, se desarrolló un segundo script en MATLAB para representar la evolución temporal del SPI durante el experimento. Esta gráfica permitió observar los cambios del índice a lo largo del tiempo y compararlos con las diferentes fases del protocolo experimental. Dado que el SPI se interpreta como un indicador indirecto de cambios autonómicos, su representación temporal resulta útil para analizar la respuesta fisiológica del sujeto [4], [5], [6].

Fragmento de código:

```python
t_spi = tiempo(picos(1:end-1));

figure
plot(t_spi,SPI,'LineWidth',2)
xlabel('Tiempo (s)')
ylabel('SPI')
title('Índice Pletismográfico Quirúrgico (SPI)')
grid on
```
Además, el código mostró en consola algunos parámetros resumen del registro, como el número de latidos detectados, el intervalo promedio entre pulsos y la frecuencia cardíaca media

```python
fprintf('Latidos detectados: %d\n',length(picos))
fprintf('RR promedio: %.3f s\n',mean(RR))
fprintf('Frecuencia cardíaca promedio: %.2f BPM\n',mean(HR))
fprintf('SPI promedio: %.2f\n',mean(SPI))
fprintf('SPI minimo: %.2f\n',min(SPI))
fprintf('SPI máximo: %.2f\n',max(SPI))
```
# 9. Resultados experimentales

### 9.1 Señal PPG cruda
En la Figura 4 se presenta la señal fotopletismográfica (PPG) adquirida directamente del sensor, sin aplicar ningún tipo de procesamiento digital. Se observa una señal periódica correspondiente a los cambios en el volumen sanguíneo periférico a lo largo del tiempo, sobre la cual pueden identificarse variaciones en amplitud y forma asociadas a cada ciclo cardíaco.

<p align="center"> <img width="300" height="190" alt="image" src="https://github.com/user-attachments/assets/a1b1e1fb-48d4-4633-a8b7-c6ffad5667d9" /> <br> <b>Fig. 4.</b> Señal PPG cruda obtenida durante la adquisición. </p>

### 9.2 Señal con picos y valles detectados
En la Figura 5 se muestra la señal PPG junto con los picos y valles detectados mediante el método del alpinista. Los picos corresponden a los máximos locales asociados a cada latido cardíaco, mientras que los valles representan los mínimos entre pulsos consecutivos. Esta detección permite segmentar la señal para la posterior extracción de parámetros fisiológicos.

<p align="center"> <img width="300" height="190" alt="image" src="https://github.com/user-attachments/assets/020f44d0-9a43-4374-8e4b-d006ed0747f1" /> <br> <b>Fig. 5.</b> Detección de picos (máximos) y valles (mínimos) en la señal PPG. </p>

### 9.3 Intervalo RR / PPI
A partir de la detección de los picos en la señal PPG se calculó el intervalo entre pulsos consecutivos (PPI), equivalente al intervalo RR en señales electrocardiográficas. Este parámetro representa el tiempo entre latidos y permite estimar la dinámica de la frecuencia cardíaca a lo largo de la señal adquirida.

### 9.4 Parámetros obtenidos
A partir del procesamiento de la señal se obtuvieron los siguientes valores característicos:
- Latidos detectados: 165
- Intervalo RR promedio: 0.719 s
- Frecuencia cardíaca promedio: 83.98 BPM
Estos valores describen el comportamiento global de la señal cardíaca durante el tiempo de adquisición.

### 9.5 Amplitud de pulso (PPGA)
La amplitud de pulso (PPGA) se obtuvo como la diferencia entre cada pico y su valle correspondiente. Este parámetro refleja la variación del volumen sanguíneo periférico en cada ciclo cardíaco y está relacionado con cambios en la perfusión y el tono vascular.

### 9.6 Evolución temporal del SPI
En la Figura 6 se presenta la evolución temporal del índice pletismográfico quirúrgico (SPI), calculado a partir de los parámetros PPI y PPGA. La señal muestra variaciones a lo largo del tiempo, permitiendo observar cambios en el comportamiento del índice durante la adquisición.

<p align="center"> <img width="300" height="190" alt="image" src="https://github.com/user-attachments/assets/76d701ba-5a51-43af-bdaf-18645facece3" /> <br> <b>Fig. 6.</b> Evolución temporal del índice pletismográfico quirúrgico (SPI). </p>

###  9.7 Valores del SPI
A partir del cálculo del índice pletismográfico quirúrgico se obtuvieron los siguientes valores:
- SPI promedio: 48.39
- SPI mínimo: 28.64
- SPI máximo: 73.70
Estos valores representan el rango de variación del índice durante la adquisición de la señal.

### 9.8 Tabla resumen(reposo, CPT, recuperación)

Se elaboró una tabla resumen que contiene los valores representativos de los parámetros calculados (frecuencia cardíaca y SPI) en tres condiciones experimentales: reposo, durante la aplicación del Cold Pressor Test (CPT) y en la fase de recuperación. Esta tabla permite organizar los resultados obtenidos para su posterior análisis.

-----   
# 10. Análisis de resultados

La señal PPG obtenida presenta un comportamiento periódico claro, lo que indica una correcta adquisición de las variaciones del volumen sanguíneo. La detección de picos y valles fue consistente al bajar el umbral de detección de picos de 6 a 3, permitiendo calcular de manera adecuada el intervalo entre pulsos (PPI) y la amplitud de pulso (PPGA). El intervalo RR promedio de 0.719 s corresponde a una frecuencia cardíaca de 83.98 BPM, lo cual es un valor fisiológicamente coherente. La variación de la amplitud de pulso a lo largo del tiempo sugiere cambios en la perfusión periférica asociados a la modulación del tono vascular.

La evolución del SPI mostró valores entre 28.64 y 73.70, con un promedio de 48.39, lo cual es consistente con el comportamiento esperado ante la aplicación del Cold Pressor Test (CPT) diseñado al ser 80s en reposo y 40s de alteración causada por el frio. Durante este estímulo se produce activación del sistema nervioso simpático, generando vasoconstricción y cambios en la frecuencia cardíaca que incrementan el SPI. Aunque los resultados son coherentes fisiológicamente, el índice obtenido corresponde a una aproximación experimental, ya que depende de un sensor no clínico y de procesamiento offline, lo cual introduce limitaciones en la precisión del sistema.

-----   
# 11. Preguntas para la discusión

### 11.1 ¿Cómo se relacionan las variaciones del volumen sanguíneo periférico con el balance autonómico?
    
Las variaciones del volumen sanguíneo periférico se relacionan directamente con el balance autonómico porque la señal PPG depende del flujo sanguíneo periférico y del tono vascular, ambos regulados por el sistema nervioso autónomo. Cuando aumenta la actividad simpática, suele presentarse vasoconstricción periférica y disminución de la perfusión, lo que puede reducir la amplitud de la onda pletismográfica; en condiciones de mayor estabilidad o predominio vagal, la perfusión periférica tiende a ser más uniforme [1], [6], [7], [10].

Además, se ha reportado que características extraídas de la PPG permiten diferenciar estados de activación autonómica, incluyendo respiración profunda, cold pressor test y activación simpática cardíaca. Por eso, los cambios en amplitud y variabilidad de la señal periférica pueden interpretarse como una manifestación indirecta del equilibrio entre actividad simpática y parasimpática [10]
    
### 11.2 ¿Cómo se compara el SPI con otros índices como ANI e índice de perfusión?

El SPI es un índice orientado al monitoreo de nocicepción que usa señales fotopletismográficas y cardiovasculares, por lo que integra cambios del pulso periférico y del intervalo entre latidos en un valor numérico fácil de interpretar [11]. En cambio, el ANI se basa principalmente en el análisis de la variabilidad de la frecuencia cardíaca, por lo que refleja sobre todo el componente parasimpático del balance autonómico [12].

Por su parte, el índice de perfusión (PI) no está diseñado específicamente para nocicepción. Este parámetro representa la relación entre la porción pulsátil y la no pulsátil de la circulación periférica y está influido principalmente por el gasto cardíaco y por el balance simpático-parasimpático [13]. Por ello, el PI es más útil para evaluar perfusión periférica y cambios hemodinámicos, mientras que el SPI busca ser más específico para cambios relacionados con nocicepción [11], [13].

De forma general, las revisiones disponibles muestran que SPI y ANI son herramientas útiles, pero ninguna es perfecta ni universal para todos los contextos clínicos. Por eso, deben interpretarse como índices complementarios dentro del análisis fisiológico y no como medidas absolutas del dolor [12], [14]

-----
# 12. Conclusiones
La práctica permitió comprobar que el SPI puede estimarse a partir de la señal PPG, utilizando principalmente el intervalo entre pulsos (PPI) y la amplitud del pulso (PPGA). Esto cumple con el objetivo de extraer información fisiológica relevante a partir de una medición no invasiva, evidenciando la relación entre la señal y la actividad del sistema nervioso autónomo.

El montaje analógico propuesto inicialmente presentó dificultades prácticas debido a su alta sensibilidad,dificultad en la  calibración y condiciones de implementación. Por esta razón, el uso del ESP32 junto con el sensor MAX30102 permitió obtener una señal más estable y adecuada para el procesamiento en MATLAB, facilitando la detección de picos y el cálculo del SPI.

Una limitación importante fue que el análisis se centró principalmente en valores globales (como el SPI promedio), sin realizar una comparación detallada entre las fases de reposo, CPT y recuperación. Esto impidió aprovechar completamente el protocolo experimental para interpretar los cambios fisiológicos inducidos por el estímulo.

En general, la práctica permitió comprender que el SPI no depende únicamente de una fórmula, sino de toda una cadena de adquisición, procesamiento y análisis. Además, se evidenció que este índice debe interpretarse como una herramienta complementaria para evaluar cambios autonómicos, teniendo en cuenta sus limitaciones experimentales y su diferencia frente a mediciones clínicas directas.

-----   

13. Bibliografías

[1] Allen, J. (2007). Photoplethysmography and its application in clinical physiological measurement. Physiological Measurement, 28(3), R1–R39. https://doi.org/10.1088/0967-3334/28/3/r01

[2] Iqbal, T., Elahi, A., Ganly, S., Wijns, W., & Shahzad, A. (2022). Photoplethysmography-Based Respiratory Rate Estimation Algorithm for health monitoring applications. Journal of Medical and Biological Engineering, 42(2), 242–252. https://doi.org/10.1007/s40846-022-00700-z

[3] Argüello-Prada, E. J. (2019). The mountaineer’s method for peak detection in photoplethysmographic signals. Revista Facultad De Ingeniería Universidad De Antioquia, 90, 42–50. https://doi.org/10.17533/udea.redin.n90a06

[4] Hubli, M., Bolt, D., & Krassioukov, A. V. (2017). Cold pressor test in spinal cord injury—revisited. Spinal Cord, 56(6), 528–537. https://doi.org/10.1038/s41393-017-0037-z

[5] Han, Y., Du, J., Wang, J., Liu, B., Yan, Y., Deng, S., Zou, Y., Jing, X., Du, J., Liu, Y., & She, Q. (2022). Cold pressor test in primary Hypertension: A Cross-Sectional Study. Frontiers in Cardiovascular Medicine, 9, 860322. https://doi.org/10.3389/fcvm.2022.860322

[6] Low, P. (2001). Fisiología del sistema nervioso autónomo. Medwave, 1(04). https://doi.org/10.5867/medwave.2001.04.3347

[7] Dalmau, R. (2019). Volumen sanguíneo: su distribución y relación con la precarga ventricular. Revista Chilena De Anestesia, 48(3), 205–207. https://doi.org/10.25237/revchilanestv48n03.02

[8] https://www.pvequip.cl/wp-content/uploads/2016/09/PVI_Spanish-Mayo-2015.pdf

[9] https://www.anestesia.org.ar/publicaciones/RAA71-02_07_Tecnologia.pdf

[10] Liu, B., Zhang, Z., et al. (2021). The Assessment of Autonomic Nervous System Activity Based on Photoplethysmography in Healthy Young Men. Frontiers in Physiology, 12, 733264. https://doi.org/10.3389/fphys.2021.733264

[11] Oh, S. K., Won, Y. J., et al. (2023). Surgical pleth index monitoring in perioperative pain management: usefulness and limitations. Korean Journal of Anesthesiology, 77(1), 31–45. https://doi.org/10.4097/kja.23158

[12] Hum, B., Christophides, A., et al. (2023). The validity and applications of the analgesia nociception index: a narrative review. Frontiers in Surgery, 10, 1234246. https://doi.org/10.3389/fsurg.2023.1234246

[13] Sun, X., He, H., et al. (2024). Peripheral perfusion index of pulse oximetry in adult patients: a narrative review. European Journal of Medical Research, 29, 457. https://doi.org/10.1186/s40001-024-02048-3

[14] Ledowski, T. (2019). Objective monitoring of nociception: a review of current commercial solutions. British Journal of Anaesthesia, 123(2), e312–e321. https://doi.org/10.1016/j.bja.2019.03.024

