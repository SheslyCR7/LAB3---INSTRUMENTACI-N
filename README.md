# Instrumentación Biomédica y Biosensores 
 LABORATORIO - 3 Estimación del nivel de estrés basada en la respuesta galvánica cutánea (GSR) 

###  Integrantes
- Shesly Nicole Colorado - 5600756
- Santiago Mora - 5600775
- Daniel Herrera - 5600588


## Requisitos
Software:
- Arduino IDE
- MATLAB

Hardware:
- Sensor de humedad del suelo YL-100
- ESP32
----
## 3. Introducción

La fotopletismografía (PPG) es una técnica óptica no invasiva que permite medir cambios en el volumen sanguíneo periférico mediante la interacción entre la luz y los tejidos biológicos [1].

A partir de esta señal es posible obtener parámetros fisiológicos como la frecuencia cardiaca y la amplitud del pulso, los cuales reflejan la actividad del sistema cardiovascular y del sistema nervioso autónomo [2].

El índice pletismográfico quirúrgico (SPI) es un parámetro derivado de la señal PPG que combina información del intervalo entre latidos y la amplitud del pulso, permitiendo estimar la respuesta fisiológica ante estímulos como el estrés o la nocicepción.

## 4. Objetivos
   
   4.1 Objetivo general
   
   Desarrollar un sistema de medición continua del índice pletismográfico quirúrgico (SPI) en condiciones ambulatorias.
   
   4.2 Objetivos específicos

   • Reconocer las características fundamentales de la onda de pulso a partir de las cuales se obtiene el SPI.
   • Construir un sistema que calcule el SPI en tiempo real y bajo condiciones ambulatorias.
   • Validar el funcionamiento del sistema desarrollado mediante un método que induzca una respuesta fisiológica similar a la que produce el dolor agudo.

## 5. Descripción general de la práctica

Se implementó un sistema de adquisición de señal PPG utilizando el sensor MAX30102 conectado a un Arduino. La señal fue procesada en MATLAB, donde se aplicó un algoritmo de detección de picos basado en el método del alpinista. A partir de esta información se calcularon variables fisiológicas y el SPI, evaluando su comportamiento bajo diferentes condiciones experimentales.
   
## 6. Materiales y herramientas utilizadas

   Arduino, sensor MAX30102, protoboard, cables, computador y MATLAB.
   
## 7. Seguridad en el laboratorio

8. Procedimiento experimental
   8.1 Montaje del sistema de adquisición

    Se conectó el sensor MAX30102 al Arduino mediante comunicación I2C para la adquisición de la señal PPG.

    <img width="642" height="415" alt="image" src="https://github.com/user-attachments/assets/398e4e7b-26f6-42a2-b0d6-675c15f29b49" />

   ### 8.2 Conexión con ESP32
En esta práctica se utilizó un ESP32 junto con el sensor MAX30102 para adquirir la señal fotopletismográfica. En el código de Arduino IDE, la comunicación con el sensor se realizó por protocolo I2C mediante Wire.begin(21,22), y la transmisión de datos hacia MATLAB se hizo por puerto serial a 115200 baudios. Además, el sistema se configuró para trabajar a una frecuencia de muestreo de 100 Hz, adecuada para registrar la onda de pulso periférica y sus variaciones en el tiempo. La PPG es una técnica óptica no invasiva que permite medir cambios de volumen sanguíneo periférico y obtener información cardiovascular a partir de la señal registrada [1].

  ### 8.3 Verificación de la señal
La verificación de la señal consistió en comprobar que la salida del sistema presentara una forma de onda periódica compatible con una señal PPG. En el código del ESP32 se tomó la lectura del canal infrarrojo con getIR() y posteriormente se invirtió la señal para facilitar su visualización. Esta etapa fue importante porque la señal PPG contiene una componente pulsátil asociada al ciclo cardiaco y una componente lenta relacionada con otros fenómenos fisiológicos [1]. Por ello, antes del procesamiento en MATLAB se verificó que la señal mostrara pulsos repetitivos y una amplitud suficientemente estable para detectar eventos característicos como picos y valles [1], [2].

   
  ### 8.4 Captura de datos

La captura de datos se realizó en MATLAB, donde el programa recibió las muestras enviadas por el ESP32, las almacenó junto con su respectiva marca temporal y las representó en tiempo real en una gráfica. El script también permitió definir la duración de la toma y guardar la señal en un archivo .mat para su análisis posterior. Esta etapa fue necesaria porque el estudio del SPI requiere una señal continua y ordenada en el tiempo, a partir de la cual puedan calcularse variables como el intervalo entre pulsos y la amplitud del pulso [1].


  ### 8.5 Detección de picos y valles
Para la detección de picos se implementó en MATLAB una versión adaptada del método del alpinista descrito por Argüello-Prada [3]. Este algoritmo se basa en contar ascensos consecutivos de la señal y utilizar un umbral para decidir cuándo una subida corresponde a un pico real. En el código, además, se incluyó un período refractario de 0.3 s para evitar detectar varias veces el mismo latido. Después de identificar los picos, se buscaron los mínimos entre pulsos consecutivos para obtener también los valles. Esta estrategia permitió caracterizar cada pulso con sus dos puntos principales: máximo y mínimo [3].
   
  ### 8.6 Cálculo del SPI
Una vez detectados los picos, se calculó el intervalo entre pulsos consecutivos (PPI) y la amplitud de la onda pletismográfica (PPGA), definida como la diferencia entre el pico y el valle asociado. Estas dos variables tienen fundamento fisiológico porque la PPG refleja cambios de volumen sanguíneo periférico, los cuales dependen tanto de la dinámica cardiaca como del tono vascular [1], [7]. En este trabajo, el SPI se estimó a partir de una combinación normalizada de PPI y PPGA, lo cual permitió obtener un índice relativo de cambio fisiológico a lo largo del experimento. Aunque esta implementación corresponde a una aproximación académica, conserva la idea de relacionar la amplitud del pulso y el intervalo entre latidos con la actividad autonómica y la respuesta fisiológica al estímulo [1], [6].

<img width="2006" height="1440" alt="image" src="https://github.com/user-attachments/assets/0f802563-062f-4003-9a82-58bd38d0d904" />


  ### 8.7 Protocolo experimental (CPT)
  
El protocolo experimental se planteó en tres etapas: reposo, aplicación del Cold Pressor Test (CPT) y recuperación. El CPT se utilizó como maniobra para inducir una respuesta fisiológica aguda semejante a la activación asociada al dolor o al estrés, permitiendo observar cambios en la señal PPG y en el SPI. Esta prueba se emplea ampliamente para estudiar reactividad cardiovascular y activación del sistema nervioso autónomo [4], [5]. Desde el punto de vista fisiológico, el estímulo frío genera respuestas autonómicas que modifican el tono vascular periférico y la dinámica hemodinámica, lo que justifica su uso en esta práctica como método de validación del sistema desarrollado [4], [5], [6].   


## 9. Fundamento teórico del SPI

El índice pletismográfico quirúrgico (SPI) se basa en la señal fotopletismográfica (PPG), una técnica óptica no invasiva que permite registrar cambios de volumen sanguíneo periférico [1]. Esta señal contiene información útil sobre el pulso cardiaco y sobre cambios en la perfusión periférica, por lo que puede emplearse para estudiar variaciones fisiológicas del sistema cardiovascular [1], [2].

El fundamento fisiológico del SPI está en que el sistema nervioso autónomo modifica tanto la frecuencia cardiaca como el tono vascular [6]. Cuando hay una respuesta de estrés o un estímulo como el Cold Pressor Test (CPT), pueden presentarse cambios en la amplitud del pulso y en el intervalo entre latidos, lo cual se refleja en la señal PPG [4], [5], [7].

En esta práctica, el SPI se estimó a partir de dos características principales de la señal:.

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

13. Técnica Cold Pressor Test (CPT)

El Cold Pressor Test es una técnica utilizada para inducir una respuesta de estrés fisiológico mediante la exposición al frío. Este estímulo activa el sistema nervioso simpático, generando cambios en la frecuencia cardiaca y en la señal PPG [4][5].

<img width="282" height="179" alt="image" src="https://github.com/user-attachments/assets/a1045cbd-82ec-4ae5-9e56-4f063caf64c1" />

<img width="440" height="360" alt="image" src="https://github.com/user-attachments/assets/27fc55ec-5aa0-41b4-b0ce-858f1c8a9bef" />


10. Código desarrollado
    
    ### 10.1 Código de captura
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

  ### 10.2 Código de detección de picos
  
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

   
   ### 10.3 Código de cálculo del SPI
   
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

  ### 10.4 Código de evolución temporal del SPI

Finalmente, se desarrolló un segundo script en MATLAB para representar la evolución temporal del SPI durante el experimento. Esta gráfica permitió observar los cambios del índice a lo largo del tiempo y compararlos con las diferentes fases del protocolo experimental. Dado que el SPI se interpreta como un indicador indirecto de cambios autonómicos, su representación temporal resulta útil para analizar la respuesta fisiológica del sujeto [4], [5], [6].

Fragmento de código:

```python
t_spi = tiempo(picos(1:end-1));

figure
plot(t_spi,SPI,'LineWidth',2)
xlabel('Tiempo (s)')
ylabel('SPI')
title('Indice Pletismografico Quirurgico (SPI)')
grid on
```
Además, el código mostró en consola algunos parámetros resumen del registro, como el número de latidos detectados, el intervalo promedio entre pulsos y la frecuencia cardiaca media

```python
fprintf('Latidos detectados: %d\n',length(picos))
fprintf('RR promedio: %.3f s\n',mean(RR))
fprintf('Frecuencia cardiaca promedio: %.2f BPM\n',mean(HR))
fprintf('SPI promedio: %.2f\n',mean(SPI))
fprintf('SPI minimo: %.2f\n',min(SPI))
fprintf('SPI maximo: %.2f\n',max(SPI))
```
11. Resultados experimentales
 - 11.1 Señal PPG cruda
 - 11.2 Señal con picos y valles detectados
  - 11.3 Intervalo RR / PPI
  - 11.4 Amplitud de pulso (PPGA)
  - 11.5 Evolución temporal del SPI
  - 11.6 Tabla resumen (reposo, CPT, recuperación)
    
12. Análisis de resultados

## 13. Preguntas para la discusión

### 13.1 ¿Cómo se relacionan las variaciones del volumen sanguíneo periférico con el balance autonómico?
    
Las variaciones del volumen sanguíneo periférico se relacionan directamente con el balance autonómico porque la señal PPG depende del flujo sanguíneo periférico y del tono vascular, ambos regulados por el sistema nervioso autónomo. Cuando aumenta la actividad simpática, suele presentarse vasoconstricción periférica y disminución de la perfusión, lo que puede reducir la amplitud de la onda pletismográfica; en condiciones de mayor estabilidad o predominio vagal, la perfusión periférica tiende a ser más uniforme [1], [6], [7], [10].

Además, se ha reportado que características extraídas de la PPG permiten diferenciar estados de activación autonómica, incluyendo respiración profunda, cold pressor test y activación simpática cardiaca. Por eso, los cambios en amplitud y variabilidad de la señal periférica pueden interpretarse como una manifestación indirecta del equilibrio entre actividad simpática y parasimpática [10]
    
### 13.2 ¿Cómo se compara el SPI con otros índices como ANI e índice de perfusión?

El SPI es un índice orientado al monitoreo de nocicepción que usa señales fotopletismográficas y cardiovasculares, por lo que integra cambios del pulso periférico y del intervalo entre latidos en un valor numérico fácil de interpretar [11]. En cambio, el ANI se basa principalmente en el análisis de la variabilidad de la frecuencia cardiaca, por lo que refleja sobre todo el componente parasimpático del balance autonómico [12].

Por su parte, el índice de perfusión (PI) no está diseñado específicamente para nocicepción. Este parámetro representa la relación entre la porción pulsátil y la no pulsátil de la circulación periférica y está influido principalmente por el gasto cardiaco y por el balance simpático-parasimpático [13]. Por ello, el PI es más útil para evaluar perfusión periférica y cambios hemodinámicos, mientras que el SPI busca ser más específico para cambios relacionados con nocicepción [11], [13].

De forma general, las revisiones disponibles muestran que SPI y ANI son herramientas útiles, pero ninguna es perfecta ni universal para todos los contextos clínicos. Por eso, deben interpretarse como índices complementarios dentro del análisis fisiológico y no como medidas absolutas del dolor [12], [14 


## 15. Conclusiones
- La práctica permitió comprobar que el SPI puede estimarse a partir de características de la onda de pulso, especialmente el intervalo entre pulsos y la amplitud del pulso, cumpliendo con el objetivo de extraer información fisiológica desde la señal PPG.

- El circuito analógico propuesto en la guía era válido en teoría, pero en la práctica resultó difícil de implementar de forma estable. Su funcionamiento dependía al mismo tiempo del sensor de reflectancia, del montaje en protoboard, del ajuste de potenciómetros, del control del offset y del nivel de interferencia; por eso, no es correcto atribuir la falla de todos los grupos a una sola causa, sino a la sensibilidad general del montaje y a su baja tolerancia a errores de calibración.

- El uso de ESP32 con MAX30102 permitió continuar con la práctica y obtener una señal PPG más estable para el procesamiento en MATLAB. Esto facilitó la captura de la señal, la detección de picos y el cálculo del SPI, aunque ya no correspondió exactamente al sistema discreto original planteado en la Parte A.

- Una limitación importante del trabajo fue que se reportó principalmente un SPI promedio, cuando la guía pedía registrar el comportamiento del índice antes, durante y después del Cold Pressor Test, además de mostrar su evolución temporal. Por tanto, faltó comparar con más claridad las tres fases del protocolo: reposo, CPT y recuperación.

- la práctica sí permitió avanzar en lo esencial: capturar una señal PPG, procesarla y estimar un SPI en condiciones ambulatorias. Sin embargo, para que el informe quedara más completo, habría sido conveniente incluir una comparación más explícita entre fases del experimento, más discusión sobre las limitaciones del montaje original y una interpretación más cuidadosa de los valores obtenidos frente al contexto clínico del SPI.


- En términos generales, la práctica permitió entender que el SPI no depende únicamente de aplicar una fórmula, sino de toda una cadena de adquisición, procesamiento e interpretación fisiológica. Aunque se logró capturar una señal PPG y estimar el índice con el sistema implementado, también quedó en evidencia que el resultado final está muy condicionado por la calidad de la señal, la estabilidad del montaje y la forma en que se analizan los datos. Además, la guía no solo pedía obtener un valor numérico, sino monitorear el SPI en reposo, durante la aplicación del Cold Pressor Test y en recuperación, así como plantear explicaciones fisiológicas y reflexionar sobre la diferencia entre nocicepción y dolor. Por eso, la principal enseñanza de la práctica fue que el SPI debe interpretarse como una herramienta de apoyo para analizar cambios autonómicos y nociceptivos, pero siempre dentro de sus limitaciones experimentales y clínicas



20. Bibliografía

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

