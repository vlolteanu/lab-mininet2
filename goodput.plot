set term pdf
set out "goodput.pdf"

set yrange [0:]

set xlabel "Rank"
set ylabel "Goodput (Mbps)"

plot \
	"tcp.dat"     using 0:1 w l title "TCP", \
	"mptcp_2.dat" using 0:1 w l title "MPTCP, 2 subflows", \
	"mptcp_8.dat" using 0:1 w l title "MPTCP, 8 subflows"

