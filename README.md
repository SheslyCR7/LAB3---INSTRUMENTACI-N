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
   
   3.1 Objetivo general
   
   Desarrollar un sistema de medición continua del índice pletismográfico quirúrgico (SPI) en condiciones ambulatorias.
   
   3.2 Objetivos específicos

   • Reconocer las características fundamentales de la onda de pulso a partir de las cuales se obtiene el SPI.
   • Construir un sistema que calcule el SPI en tiempo real y bajo condiciones ambulatorias.
   • Validar el funcionamiento del sistema desarrollado mediante un método que induzca una respuesta fisiológica similar a la que produce el dolor agudo.

## 5. Descripción general de la práctica

Se implementó un sistema de adquisición de señal PPG utilizando el sensor MAX30102 conectado a un Arduino. La señal fue procesada en MATLAB, donde se aplicó un algoritmo de detección de picos basado en el método del alpinista. A partir de esta información se calcularon variables fisiológicas y el SPI, evaluando su comportamiento bajo diferentes condiciones experimentales.
   
## 7. Materiales y herramientas utilizadas

   Arduino, sensor MAX30102, protoboard, cables, computador y MATLAB.
   
## 9. Seguridad en el laboratorio

10. Procedimiento experimental
   7.1 Montaje del sistema de adquisición

    Se conectó el sensor MAX30102 al Arduino mediante comunicación I2C para la adquisición de la señal PPG.

    <img width="642" height="415" alt="image" src="https://github.com/user-attachments/assets/398e4e7b-26f6-42a2-b0d6-675c15f29b49" />

   ### 7.2 Conexión con ESP32
En esta práctica se utilizó un ESP32 junto con el sensor MAX30102 para adquirir la señal fotopletismográfica. En el código de Arduino IDE, la comunicación con el sensor se realizó por protocolo I2C mediante Wire.begin(21,22), y la transmisión de datos hacia MATLAB se hizo por puerto serial a 115200 baudios. Además, el sistema se configuró para trabajar a una frecuencia de muestreo de 100 Hz, adecuada para registrar la onda de pulso periférica y sus variaciones en el tiempo. La PPG es una técnica óptica no invasiva que permite medir cambios de volumen sanguíneo periférico y obtener información cardiovascular a partir de la señal registrada [1].

  ### 7.3 Verificación de la señal
La verificación de la señal consistió en comprobar que la salida del sistema presentara una forma de onda periódica compatible con una señal PPG. En el código del ESP32 se tomó la lectura del canal infrarrojo con getIR() y posteriormente se invirtió la señal para facilitar su visualización. Esta etapa fue importante porque la señal PPG contiene una componente pulsátil asociada al ciclo cardiaco y una componente lenta relacionada con otros fenómenos fisiológicos [1]. Por ello, antes del procesamiento en MATLAB se verificó que la señal mostrara pulsos repetitivos y una amplitud suficientemente estable para detectar eventos característicos como picos y valles [1], [2].

   
  ### 7.4 Captura de datos

La captura de datos se realizó en MATLAB, donde el programa recibió las muestras enviadas por el ESP32, las almacenó junto con su respectiva marca temporal y las representó en tiempo real en una gráfica. El script también permitió definir la duración de la toma y guardar la señal en un archivo .mat para su análisis posterior. Esta etapa fue necesaria porque el estudio del SPI requiere una señal continua y ordenada en el tiempo, a partir de la cual puedan calcularse variables como el intervalo entre pulsos y la amplitud del pulso [1].


  ### 7.5 Detección de picos y valles
Para la detección de picos se implementó en MATLAB una versión adaptada del método del alpinista descrito por Argüello-Prada [3]. Este algoritmo se basa en contar ascensos consecutivos de la señal y utilizar un umbral para decidir cuándo una subida corresponde a un pico real. En el código, además, se incluyó un período refractario de 0.3 s para evitar detectar varias veces el mismo latido. Después de identificar los picos, se buscaron los mínimos entre pulsos consecutivos para obtener también los valles. Esta estrategia permitió caracterizar cada pulso con sus dos puntos principales: máximo y mínimo [3].
   
  ### 7.6 Cálculo del SPI
Una vez detectados los picos, se calculó el intervalo entre pulsos consecutivos (PPI) y la amplitud de la onda pletismográfica (PPGA), definida como la diferencia entre el pico y el valle asociado. Estas dos variables tienen fundamento fisiológico porque la PPG refleja cambios de volumen sanguíneo periférico, los cuales dependen tanto de la dinámica cardiaca como del tono vascular [1], [7]. En este trabajo, el SPI se estimó a partir de una combinación normalizada de PPI y PPGA, lo cual permitió obtener un índice relativo de cambio fisiológico a lo largo del experimento. Aunque esta implementación corresponde a una aproximación académica, conserva la idea de relacionar la amplitud del pulso y el intervalo entre latidos con la actividad autonómica y la respuesta fisiológica al estímulo [1], [6].

  ### 7.7 Protocolo experimental (CPT)
  
El protocolo experimental se planteó en tres etapas: reposo, aplicación del Cold Pressor Test (CPT) y recuperación. El CPT se utilizó como maniobra para inducir una respuesta fisiológica aguda semejante a la activación asociada al dolor o al estrés, permitiendo observar cambios en la señal PPG y en el SPI. Esta prueba se emplea ampliamente para estudiar reactividad cardiovascular y activación del sistema nervioso autónomo [4], [5]. Desde el punto de vista fisiológico, el estímulo frío genera respuestas autonómicas que modifican el tono vascular periférico y la dinámica hemodinámica, lo que justifica su uso en esta práctica como método de validación del sistema desarrollado [4], [5], [6].   


12. Fundamento teórico del SPI

13. 
14. Técnica Cold Pressor Test (CPT)

El Cold Pressor Test es una técnica utilizada para inducir una respuesta de estrés fisiológico mediante la exposición al frío. Este estímulo activa el sistema nervioso simpático, generando cambios en la frecuencia cardiaca y en la señal PPG [4][5].

<img width="282" height="179" alt="image" src="https://github.com/user-attachments/assets/a1045cbd-82ec-4ae5-9e56-4f063caf64c1" />

<img width="440" height="360" alt="image" src="https://github.com/user-attachments/assets/27fc55ec-5aa0-41b4-b0ce-858f1c8a9bef" />


14. Código desarrollado
    10.1 Código de captura
    10.2 Código de detección de picos
    10.3 Código de cálculo del SPI
    10.4 Código de evolución temporal del SPI
15. Resultados experimentales
    11.1 Señal PPG cruda
    11.2 Señal con picos y valles detectados
    11.3 Intervalo RR / PPI
    11.4 Amplitud de pulso (PPGA)
    11.5 Evolución temporal del SPI
    11.6 Tabla resumen (reposo, CPT, recuperación)
16. Análisis de resultados
17. Preguntas para la discusión
    13.1 ¿Cómo se relacionan las variaciones del volumen sanguíneo periférico con el balance autonómico?
    
    El VSP periférico modula por reflejos venoarteriales: simpático causa vasoconstricción centralizando volumen (↓VSP periférico), parasimpático lo distribuye (↑flujo esplácnico/periférico). Desbalance simpático-vagal (↑simpático) reduce VFC y PPG variabilidad, como en hiperreactividad cardiovascular basal; Poincaré plot (SD1/SD2 ↓) lo confirma. [6]
    
    13.2 ¿Cómo se compara el SPI con otros índices como ANI e índice de perfusión?

    SPI (GE Healthcare) integra PPGA y HBI para nocicepción (rango 0-100, ideal 20-50); ANI (parasimpático vía HRV-RR) mide analgesia (↑50=buena), sensible a vagal pero menos a hipovolemia. Índice perfusión (PI/PVi, Masimo) evalúa perfusión/volumen (PI=AC/DC %, PVi>13% óptimo), sensible a volemia/vasotono pero no específico de nocicepción (↑PVi=buena hidratación) [8][9].    
18. Conclusiones
19. Bibliografía

[1] Allen, J. (2007). Photoplethysmography and its application in clinical physiological measurement. Physiological Measurement, 28(3), R1–R39. https://doi.org/10.1088/0967-3334/28/3/r01

[2] Iqbal, T., Elahi, A., Ganly, S., Wijns, W., & Shahzad, A. (2022). Photoplethysmography-Based Respiratory Rate Estimation Algorithm for health monitoring applications. Journal of Medical and Biological Engineering, 42(2), 242–252. https://doi.org/10.1007/s40846-022-00700-z

[3] Argüello-Prada, E. J. (2019). The mountaineer’s method for peak detection in photoplethysmographic signals. Revista Facultad De Ingeniería Universidad De Antioquia, 90, 42–50. https://doi.org/10.17533/udea.redin.n90a06

[4] Hubli, M., Bolt, D., & Krassioukov, A. V. (2017). Cold pressor test in spinal cord injury—revisited. Spinal Cord, 56(6), 528–537. https://doi.org/10.1038/s41393-017-0037-z

[5] Han, Y., Du, J., Wang, J., Liu, B., Yan, Y., Deng, S., Zou, Y., Jing, X., Du, J., Liu, Y., & She, Q. (2022). Cold pressor test in primary Hypertension: A Cross-Sectional Study. Frontiers in Cardiovascular Medicine, 9, 860322. https://doi.org/10.3389/fcvm.2022.860322

[6] Low, P. (2001). Fisiología del sistema nervioso autónomo. Medwave, 1(04). https://doi.org/10.5867/medwave.2001.04.3347

[7] Dalmau, R. (2019). Volumen sanguíneo: su distribución y relación con la precarga ventricular. Revista Chilena De Anestesia, 48(3), 205–207. https://doi.org/10.25237/revchilanestv48n03.02

[8] https://www.pvequip.cl/wp-content/uploads/2016/09/PVI_Spanish-Mayo-2015.pdf

[9] https://www.anestesia.org.ar/publicaciones/RAA71-02_07_Tecnologia.pdf

