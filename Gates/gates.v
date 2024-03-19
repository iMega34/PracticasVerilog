
/*
Operaciones básicas combinacionales

Entradas:
    A, B: Entradas de la operación.

Salidas:
    LEDR: Salidas de la operación.
*/
module gates (
    input A, B,
    output [7:0] LEDR
);

    assign LEDR[0] = ~A;
    assign LEDR[1] = ~B;
    assign LEDR[2] = A * B;
    assign LEDR[3] = A | B;
    assign LEDR[4] = ~(A * B);
    assign LEDR[5] = ~(A | B);
    assign LEDR[6] = A ^ B;
    assign LEDR[7] = ~(A ^ B);

endmodule
