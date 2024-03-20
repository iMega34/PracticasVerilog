
/*
Controlador de PWM

Parámetros:
    CLK_FREQ: Frecuencia del reloj interno de la tarjeta. Por defecto, 50 MHz
    DUTY_FREQ: Frecuencia de trabajo del dispositivo. Por defecto, 50 Hz.

Entradas:
    MAX10_CLK1_50: Reloj interno de la FPGA - 50 MHz.
    KEY: Botones de la FPGA.
    SW: Switches de la FPGA.

Salidas:
    HEX0, HEX1, HEX2: Display de 7 segmentos.
    GPIO: Pines de propósito general.
*/
module PWM #(
    parameter CLK_FREQ = 50_000_000,
    parameter DUTY_FREQ = 50
) (
    input MAX10_CLK1_50,            // Reloj interno de la FPGA - 50 MHz
    input [1:0] KEY,                // Botones de la FPGA
    input [9:0] SW,                 // Switches de la FPGA
    output [6:0] HEX0, HEX1, HEX2,  // Display de 7 segmentos
    output [9:0] GPIO               // Pines de propósito general
);

    // Frecuencia del PWM
    localparam PWM_FREQ = CLK_FREQ / DUTY_FREQ;

    // Señal de conteo - Se determina a partir del logaritmo en base 2 de
    // la frecuencia del PWM
    wire [$clog2(PWM_FREQ) - 1:0] count_wire;

    // Instanciación del contador SIN `clock_divider`
    counter #(
        .C_MAX(PWM_FREQ)
    ) COUNTER_WRAPPER (
        .clk(MAX10_CLK1_50),
        .rst_n_a(KEY[1]),
        .out_data(count_wire)
    );

    // Instanciación del comparador
    grados_comp #(
        .PWM_FREQ(PWM_FREQ),
        .PULSE_WIDTH(DUTY_FREQ),
        .MAX_RANGE(180),
        .MIN_PULSE(1),
        .MAX_PULSE(2)
    ) COMP_WRAPPER (
        .counter(count_wire),
        .switch_input(SW[7:0]),
        .pwm_output(GPIO[0])
    );

    // Instanciación del módulo de control de los displays de 7 segmentos
    // solo se utilizan los primeros 3 displays
    segmentos_7_wr SEGMENTOS_7_WRAPPER (
        .SW(SW[7:0]),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2)
    );
endmodule
