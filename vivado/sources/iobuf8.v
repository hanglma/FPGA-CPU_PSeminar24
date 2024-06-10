module IO_buf (
    input  wire            oe,
    input  wire      [7:0] DataIn,
    inout  wire      [7:0] DataBus,
    output reg  [7:0] DataOut
);
    // wenn oe == HIGH dann DataOut
    assign DataBus = oe ? DataOut : DataIn;

    always @(*) begin
        if (!oe) begin
            DataOut <= DataBus;
        end
    end

endmodule