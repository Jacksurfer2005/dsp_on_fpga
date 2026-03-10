module ref_fironfpga (
  input                   CLOCK_50,
  input          [3:0]    KEY,
  input          [9:0]    SW,
  output         [9:0]    LEDR,
  input                   AUD_ADCDAT,
  inout                   AUD_ADCLRCK,
  inout                   AUD_BCLK,
  output                  AUD_DACDAT,
  inout                   AUD_DACLRCK,
  output                  AUD_XCK,
  output                  FPGA_I2C_SCLK,
  inout                   FPGA_I2C_SDAT
);

    // Module TOP wrapper
    top TOP (
        .clk            ( CLOCK_50      ),
        .reset_n        ( KEY[3]        ),
        .is_key_config  ( ~KEY[3:0]     ),
        .sw             ( SW[9:0]       ),
        .bclk           ( AUD_BCLK      ),
        .serial_data    ( AUD_DACDAT    ),
        .xck            ( AUD_XCK       ),
        .daclrck        ( AUD_DACLRCK   ),
        .sclk           ( FPGA_I2C_SCLK ),
        .sdin           ( FPGA_I2C_SDAT ),
        .led_red        ( LEDR          )
    );

endmodule