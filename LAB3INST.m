clc; clear; close all;

% ================= DATOS DEL EXPERIMENTO =================
nombre = input('Ingrese el nombre del sujeto: ','s');
duracion = input('Ingrese la duracion de la toma de datos (segundos): ');

% ================= SERIAL =================
puerto = "COM13";
baudrate = 115200;

s = serialport(puerto, baudrate);
configureTerminator(s,"LF");
flush(s);

% ================= PARAMETROS =================
fs = 100;

senal = [];
tiempo = [];

% ventana grafica
N = 300;
datos = zeros(1,N);
t = (0:N-1)/fs;

% ================= GRAFICA CRUDA =================
figure
p1 = plot(t,datos,'b');
title(['PPG Sin procesamiento - ' nombre])
xlabel('Tiempo (s)')
ylabel('Amplitud')
grid on

tic

% ================= CAPTURA =================
while toc < duracion && ishandle(p1)

    if s.NumBytesAvailable > 0
        dato = readline(s);
        valor = str2double(dato);

        if ~isnan(valor)
            t_actual = toc;

            senal(end+1) = valor;
            tiempo(end+1) = t_actual;

            datos = [datos(2:end) valor];
            set(p1,'YData',datos)
            drawnow limitrate
        end
    end
end

disp('Captura finalizada')

% ================= GUARDAR DATOS =================
archivo = "PPG_" + nombre + ".mat";
save(archivo,'senal','tiempo','fs')
disp(['Guardado en ' archivo])

%% ==========================================================
%% ========== DETECCION DE PICOS - METODO ALPINISTA =========
%% ==========================================================

num_upsteps = 0;
threshold = 4;

possible_peak = false;
possible_valley = false;

value_possible_peak = 0;
time_possible_peak = 0;

value_possible_valley = 0;
time_possible_valley = 0;

picos = [];
valles = [];

refractory = 0.3;
ultimo_pico = -inf;

for i = 2:length(senal)

    if senal(i) > senal(i-1)
        num_upsteps = num_upsteps + 1;

        if possible_valley == false
            possible_valley = true;
            value_possible_valley = senal(i-1);
            time_possible_valley = tiempo(i-1);
        end

    else
        if num_upsteps >= threshold
            possible_peak = true;
            value_possible_peak = senal(i-1);
            time_possible_peak = tiempo(i-1);
        else
            if possible_valley == true
                if senal(i) <= value_possible_valley
                    value_possible_valley = senal(i);
                    time_possible_valley = tiempo(i);
                end
            end
        end

        if possible_peak == true
            t_pico = time_possible_peak;

            if (t_pico - ultimo_pico) > refractory
                picos(end+1) = find(tiempo == time_possible_peak,1);
                ultimo_pico = t_pico;

                if possible_valley == true
                    valles(end+1) = find(tiempo == time_possible_valley,1);
                    possible_valley = false;
                end

                threshold = max(1, round(0.6 * num_upsteps));
            end

            possible_peak = false;
        end

        num_upsteps = 0;
    end
end

%% ================= FIGURA PICOS =================
figure
plot(tiempo,senal,'b')
hold on
plot(tiempo(picos),senal(picos),'ro','MarkerFaceColor','r')

if ~isempty(valles)
    plot(tiempo(valles),senal(valles),'go','MarkerFaceColor','g')
    legend('Señal','Picos','Valles')
else
    legend('Señal','Picos')
end

title('Deteccion de picos PPG - Metodo del alpinista')
xlabel('Tiempo (s)')
ylabel('Amplitud')
grid on

%% ==========================================================
%% ================= CALCULO RR ==============================
%% ==========================================================

if length(picos) < 3
    error("No hay suficientes picos detectados")
end

RR = diff(tiempo(picos));
HR = 60 ./ RR;

%% ==========================================================
%% ================= MINIMOS ENTRE PICOS ====================
%% ==========================================================

minimos = zeros(1,length(picos)-1);

for k = 1:length(picos)-1
    segmento = senal(picos(k):picos(k+1));
    [~,idx] = min(segmento);
    minimos(k) = picos(k) + idx - 1;
end

%% ================= AMPLITUD DEL PULSO =================
PPGA = senal(picos(1:end-1)) - senal(minimos);

%% ================= INTERVALO ENTRE PULSOS =================
PPI = RR;

%% ================= NORMALIZACION =================
PPGA_norm = PPGA / max(PPGA);
PPI_norm = PPI / max(PPI);

%% ================= SPI =================
SPI = 100 * (0.33 * PPI_norm + 0.67 * (1 - PPGA_norm));
t_spi = tiempo(picos(1:end-1));

%% ================= FIGURA SPI =================
figure
plot(t_spi,SPI,'LineWidth',2)
xlabel('Tiempo (s)')
ylabel('SPI')
title('Indice Pletismografico Quirurgico (SPI)')
ylim([0 100])
grid on

%% ================= RESULTADOS =================
fprintf('\n----- RESULTADOS -----\n')
fprintf('Latidos detectados: %d\n',length(picos))
fprintf('RR promedio: %.3f s\n',mean(RR))
fprintf('SPI: %.2f\n',mean(SPI))
