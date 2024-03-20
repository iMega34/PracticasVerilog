
/*
Sistema de contraseña de cuatro dígitos.

Parámetros:
    PW_D1: Primer dígito de la contraseña. Por defecto, 0.
    PW_D2: Segundo dígito de la contraseña. Por defecto, 0.
    PW_D3: Tercer dígito de la contraseña. Por defecto, 0.
    PW_D4: Cuarto dígito de la contraseña. Por defecto, 0.

Entradas:
    clk: Reloj de entrada.
    rst_n_a: Reset asíncrono activo bajo.
    enable: Habilitador del sistema.
    input_psw: Entrada de la contraseña.

Salidas:
    psw_output: Salida de la contraseña.
        00: Sin acción
        01: Contraseña incorrecta
        10: Contraseña correcta
*/
module FSM_PSW #(
    parameter  PW_D1 = 0,
    parameter  PW_D2 = 0,
    parameter  PW_D3 = 0,
    parameter  PW_D4 = 0
) (
    input clk, rst_n_a,
    input enable,
    input [3:0] input_psw,
    output reg [1:0] psw_output
);

    parameter   IDLE = 0,
                CHECK_D1 = 1,
                CHECK_D2 = 2,
                CHECK_D3 = 3,
                CHECK_D4 = 4,
                CORRECT  = 5;

    reg [2:0] current_state, next_state;

    always @(posedge clk or negedge rst_n_a) begin
        begin
            if (!rst_n_a)
                current_state <= IDLE;
            else
                current_state <= next_state;
        end
    end

    always @(posedge enable) begin
        psw_output = 2'b00;
        case (current_state)
            IDLE:
                begin
                    if (enable == 0)
                        next_state = IDLE;
                    else
                        next_state = CHECK_D1;
                end
            CHECK_D1:
                begin
                    if (enable == 1)
                        begin
                            if (input_psw == PW_D1)
                                next_state = CHECK_D2;
                            else
                                begin
                                    next_state = IDLE;
                                    psw_output = 2'b01;
                                end
                        end
                    else
                        next_state = CHECK_D1;
                end
            CHECK_D2:
                begin
                    if (enable == 1)
                        begin
                            if (input_psw == PW_D2)
                                next_state = CHECK_D3;
                            else
                                begin
                                    next_state = IDLE;
                                    psw_output = 2'b01;
                                end
                        end
                    else
                        next_state = CHECK_D2;
                end
            CHECK_D3:
                begin
                    if (enable == 1)
                        begin
                            if (input_psw == PW_D3)
                                next_state = CHECK_D4;
                            else
                                begin
                                    next_state = IDLE;
                                    psw_output = 2'b01;
                                end
                        end
                    else
                        next_state = CHECK_D3;
                end
            CHECK_D4:
                begin
                    if (enable == 1)
                        begin
                            if (input_psw == PW_D4)
                                next_state = CORRECT;
                            else
                                begin
                                    next_state = IDLE;
                                    psw_output = 2'b01;
                                end
                        end
                    else
                        next_state = CHECK_D4;
                end
            CORRECT:
                begin
                    if (enable == 1)
                        next_state = IDLE;
                    else
                        next_state = CORRECT;
                        psw_output = 2'b10;
                end
            default:
                next_state = IDLE;
        endcase
    end

endmodule
