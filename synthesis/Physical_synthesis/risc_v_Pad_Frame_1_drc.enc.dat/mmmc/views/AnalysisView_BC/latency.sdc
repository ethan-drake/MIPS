set_clock_latency -rise 0.4  [get_clocks {My_CLK}]
set_clock_latency -fall 0.3  [get_clocks {My_CLK}]
set_clock_latency -source -early -min -rise 0.2 [get_clocks {My_CLK}]
set_clock_latency -source -early -min -fall 0.15 [get_clocks {My_CLK}]
set_clock_latency -source -early -max -rise 0.2 [get_clocks {My_CLK}]
set_clock_latency -source -early -max -fall 0.15 [get_clocks {My_CLK}]
set_clock_latency -source -late -min -rise 0.2 [get_clocks {My_CLK}]
set_clock_latency -source -late -min -fall 0.15 [get_clocks {My_CLK}]
set_clock_latency -source -late -max -rise 0.2 [get_clocks {My_CLK}]
set_clock_latency -source -late -max -fall 0.15 [get_clocks {My_CLK}]
set_clock_latency -source -early -min -rise  0.491605 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -early -min -fall  0.313361 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -early -max -rise  0.491605 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -early -max -fall  0.313361 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -late -min -rise  0.491605 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -late -min -fall  0.313361 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -late -max -rise  0.491605 [get_ports {clk}] -clock My_CLK 
set_clock_latency -source -late -max -fall  0.313361 [get_ports {clk}] -clock My_CLK 
