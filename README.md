# LAB3---INSTRUMENTACI-N


1. Integrantes: Shesly Colorado 5600756 -
   
3. Introducción

La fotopletismografía (PPG) es una técnica óptica que permite medir variaciones en el volumen sanguíneo periférico. A partir de esta señal, es posible extraer información cardiovascular como la frecuencia cardiaca y la amplitud del pulso.

El índice pletismográfico quirúrgico (SPI) es un parámetro que combina la información del intervalo entre latidos y la amplitud del pulso, permitiendo estimar el balance entre el sistema nervioso simpático y parasimpático.

El SPI toma valores entre 0 y 100. Valores bajos indican un estado estable o relajado, mientras que valores altos están asociados a estrés o nocicepción.

4. Objetivos
   
   3.1 Objetivo general
   
   Desarrollar un sistema de medición continua del índice pletismográfico quirúrgico (SPI) en condiciones ambulatorias.
   
   3.2 Objetivos específicos

   • Reconocer las características fundamentales de la onda de pulso a partir de las cuales se obtiene el SPI.
   • Construir un sistema que calcule el SPI en tiempo real y bajo condiciones ambulatorias.
   • Validar el funcionamiento del sistema desarrollado mediante un método que induzca una respuesta fisiológica similar a la que produce el dolor agudo.

5. Descripción general de la práctica

Se diseñó un sistema de adquisición y procesamiento de señal PPG utilizando un sensor óptico y MATLAB, con el fin de calcular el SPI y analizar su comportamiento en diferentes condiciones fisiológicas.
   
7. Materiales y herramientas utilizadas
8. Seguridad en el laboratorio
9. Procedimiento experimental
   7.1 Montaje del sistema de adquisición
   7.2 Conexión con Arduino
   7.3 Verificación de la señal
   7.4 Captura de datos
   7.5 Detección de picos y valles
   7.6 Cálculo del SPI
   7.7 Protocolo experimental (CPT)
10. Fundamento teórico del SPI
11. Técnica Cold Pressor Test (CPT)
12. Código desarrollado
    10.1 Código de captura
    10.2 Código de detección de picos
    10.3 Código de cálculo del SPI
    10.4 Código de evolución temporal del SPI
13. Resultados experimentales
    11.1 Señal PPG cruda
    11.2 Señal con picos y valles detectados
    11.3 Intervalo RR / PPI
    11.4 Amplitud de pulso (PPGA)
    11.5 Evolución temporal del SPI
    11.6 Tabla resumen (reposo, CPT, recuperación)
14. Análisis de resultados
15. Preguntas para la discusión
    13.1 Relación volumen sanguíneo – sistema autónomo
    13.2 Comparación SPI vs ANI e índice de perfusión
16. Conclusiones
17. Bibliografía

1. Argüello-Prada, E. J. (2019). The mountaineer’s method for peak detection in photoplethysmographic signals. Revista Facultad De Ingeniería Universidad De Antioquia, 90, 42–50. https://doi.org/10.17533/udea.redin.n90a06
2. Iqbal, T., Elahi, A., Ganly, S., Wijns, W., & Shahzad, A. (2022). Photoplethysmography-Based Respiratory Rate Estimation Algorithm for health monitoring applications. Journal of Medical and Biological Engineering, 42(2), 242–252. https://doi.org/10.1007/s40846-022-00700-z
3. Hubli, M., Bolt, D., & Krassioukov, A. V. (2017). Cold pressor test in spinal cord injury—revisited. Spinal Cord, 56(6), 528–537. https://doi.org/10.1038/s41393-017-0037-z
4. Han, Y., Du, J., Wang, J., Liu, B., Yan, Y., Deng, S., Zou, Y., Jing, X., Du, J., Liu, Y., & She, Q. (2022). Cold pressor test in primary Hypertension: A Cross-Sectional Study. Frontiers in Cardiovascular Medicine, 9, 860322. https://doi.org/10.3389/fcvm.2022.860322
5. Allen, J. (2007). Photoplethysmography and its application in clinical physiological measurement. Physiological Measurement, 28(3), R1–R39. https://doi.org/10.1088/0967-3334/28/3/r01
6. 

