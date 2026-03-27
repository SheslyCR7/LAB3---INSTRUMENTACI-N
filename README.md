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
3. Introducción

La fotopletismografía (PPG) es una técnica óptica no invasiva que permite medir cambios en el volumen sanguíneo periférico mediante la interacción entre la luz y los tejidos biológicos [1].

A partir de esta señal es posible obtener parámetros fisiológicos como la frecuencia cardiaca y la amplitud del pulso, los cuales reflejan la actividad del sistema cardiovascular y del sistema nervioso autónomo [2].

El índice pletismográfico quirúrgico (SPI) es un parámetro derivado de la señal PPG que combina información del intervalo entre latidos y la amplitud del pulso, permitiendo estimar la respuesta fisiológica ante estímulos como el estrés o la nocicepción.

4. Objetivos
   
   3.1 Objetivo general
   
   Desarrollar un sistema de medición continua del índice pletismográfico quirúrgico (SPI) en condiciones ambulatorias.
   
   3.2 Objetivos específicos

   • Reconocer las características fundamentales de la onda de pulso a partir de las cuales se obtiene el SPI.
   • Construir un sistema que calcule el SPI en tiempo real y bajo condiciones ambulatorias.
   • Validar el funcionamiento del sistema desarrollado mediante un método que induzca una respuesta fisiológica similar a la que produce el dolor agudo.

5. Descripción general de la práctica

Se implementó un sistema de adquisición de señal PPG utilizando el sensor MAX30102 conectado a un Arduino. La señal fue procesada en MATLAB, donde se aplicó un algoritmo de detección de picos basado en el método del alpinista. A partir de esta información se calcularon variables fisiológicas y el SPI, evaluando su comportamiento bajo diferentes condiciones experimentales.
   
7. Materiales y herramientas utilizadas

   Arduino, sensor MAX30102, protoboard, cables, computador y MATLAB.
   
9. Seguridad en el laboratorio
10. Procedimiento experimental
   7.1 Montaje del sistema de adquisición
   7.2 Conexión con Arduino
   7.3 Verificación de la señal
   7.4 Captura de datos
   7.5 Detección de picos y valles
   7.6 Cálculo del SPI
   7.7 Protocolo experimental (CPT)
11. Fundamento teórico del SPI
12. Técnica Cold Pressor Test (CPT)
13. Código desarrollado
    10.1 Código de captura
    10.2 Código de detección de picos
    10.3 Código de cálculo del SPI
    10.4 Código de evolución temporal del SPI
14. Resultados experimentales
    11.1 Señal PPG cruda
    11.2 Señal con picos y valles detectados
    11.3 Intervalo RR / PPI
    11.4 Amplitud de pulso (PPGA)
    11.5 Evolución temporal del SPI
    11.6 Tabla resumen (reposo, CPT, recuperación)
15. Análisis de resultados
16. Preguntas para la discusión
    13.1 ¿Cómo se relacionan las variaciones del volumen sanguíneo periférico con el balance autonómico?
    
    13.2 ¿Cómo se compara el SPI con otros índices como ANI e índice de perfusión?
    
18. Conclusiones
19. Bibliografía

[1] Allen, J. (2007). Photoplethysmography and its application in clinical physiological measurement. Physiological Measurement, 28(3), R1–R39. https://doi.org/10.1088/0967-3334/28/3/r01

[2] Iqbal, T., Elahi, A., Ganly, S., Wijns, W., & Shahzad, A. (2022). Photoplethysmography-Based Respiratory Rate Estimation Algorithm for health monitoring applications. Journal of Medical and Biological Engineering, 42(2), 242–252. https://doi.org/10.1007/s40846-022-00700-z

[3] Argüello-Prada, E. J. (2019). The mountaineer’s method for peak detection in photoplethysmographic signals. Revista Facultad De Ingeniería Universidad De Antioquia, 90, 42–50. https://doi.org/10.17533/udea.redin.n90a06

[4] Hubli, M., Bolt, D., & Krassioukov, A. V. (2017). Cold pressor test in spinal cord injury—revisited. Spinal Cord, 56(6), 528–537. https://doi.org/10.1038/s41393-017-0037-z

[5] Han, Y., Du, J., Wang, J., Liu, B., Yan, Y., Deng, S., Zou, Y., Jing, X., Du, J., Liu, Y., & She, Q. (2022). Cold pressor test in primary Hypertension: A Cross-Sectional Study. Frontiers in Cardiovascular Medicine, 9, 860322. https://doi.org/10.3389/fcvm.2022.860322

