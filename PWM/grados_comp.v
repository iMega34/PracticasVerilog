
/*
Comparador para control de PWM

Convierte la entrada binaria de los switches de la FPGA a un valor de 0 a 180
y compara este valor con el valor del contador para generar la señal de PWM.

La 10M50DAF484C7G es una FPGA con una frecuencia de reloj de 50 MHz.
Un servo motor SG90 tiene una frecuencia de trabajo de 50 Hz y un rango de
movimiento de 0 a 180 grados.

Parámetros:
    PWM_FREQ: Frecuencia del PWM. Por defecto, 1 MHz.
    DUTY_FREQ: Frecuencia de trabajo del PWM. Por defecto, 50 Hz.
    MAX_RANGE: Rango máximo de movimiento del servo. Por defecto, 180 grados.
    MIN_PULSE: Pulso mínimo del servo. Por defecto, 1 ms.
    MAX_PULSE: Pulso máximo del servo. Por defecto, 2 ms.

Entradas:
    counter: Valor del contador.
    switch_input: Valor de los switches de la FPGA.

Salidas:
    pwm_output: Salida del PWM
*/
module grados_comp #(
    parameter PWM_FREQ = 1_000_000,
    parameter PULSE_WIDTH = 20,
    parameter MAX_RANGE = 180,
    parameter MIN_PULSE = 1,
    parameter MAX_PULSE = 4
) (
    input [20:0] counter,
    input [7:0] switch_input,
    output reg pwm_output
);

    // Variable auxiliar para el cálculo del PWM
    wire [20:0] comp_wire;

    assign comp_wire = switch_input > 180
                                    ? 100_000
                                    : (50_000 * switch_input / 180) + 50_000; 

    // Comparación del valor del contador con el valor del PWM
    always @(*) begin
        if (counter < comp_wire)
            pwm_output <= 1;
        else
            pwm_output <= 0;
    end

endmodule
