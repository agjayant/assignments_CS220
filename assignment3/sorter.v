module sorter (
clock , // Clock input
reset , // active high, synchronous Reset input
input_weight , // input weight
grp1 , grp2, grp3, grp4, grp5 , grp6, // output 
cur_grp // for current group number
); // End of port list


//-------------Input Ports-----------------------------
input clock ;
input reset ;
input [11:0] input_weight ;


//-------------Output Ports----------------------------
output [7:0] grp1;
output [7:0] grp2;
output [7:0] grp3;
output [7:0] grp4;
output [7:0] grp5;
output [7:0] grp6;
output [2:0] cur_grp;

//-------------Input ports Data Type-------------------
wire clock ;
wire reset ;
wire [11:0] input_weight ;

//-------------Output Ports Data Type------------------
reg [7:0] grp1 ;
reg [7:0] grp2 ;
reg [7:0] grp3 ;
reg [7:0] grp4 ;
reg [7:0] grp5 ;
reg [7:0] grp6 ;
reg [2:0] cur_grp;

//-------------Variables Used--------------------------
reg flag ;    // if 1 -> update group count else add weight to previous weight and update current group number
reg i; // for iteration
reg [11:0] prev_weight; //to keep the previous weight saved

// At each edge of the clock :- outputa are updated

always @ (negedge clock)
begin : SORT // Block Name

  // At every edge of clock if reset is active, we set the counts, current group and flag to 0

  if (reset == 1'b1) begin
	  
        grp1=0;
	grp2=0;
	grp3=0;
	grp4=0;
	grp5=0;
	grp6=0;

	flag = 1;
        cur_grp = 0 ; 
	prev_weight = 0;
  end 
  // if input_weight is one then count is updated
  else if (input_weight == 0) begin
        flag = 1 ; 
        cur_grp = 0;
	prev_weight = 0;
  end 
  else begin
       	 //adding to the prev_weight
	 prev_weight = prev_weight + input_weight;

	 //updating cur_grp accordingly 
	 //updating counts if flag = 1
		  if (prev_weight >= 1 && prev_weight <= 200 ) begin 
			  cur_grp = 1;
			  if (flag == 1) begin
				  grp1 = grp1 + 1;
				  flag = 0;
			  end				 
		  end
		  else if (prev_weight > 200 && prev_weight < 501 ) begin 
			  cur_grp = 2;
			  if (flag == 1) begin
				  grp2 = grp2 + 1;
				  flag = 0;
			  end		
		  end
		  else if (prev_weight > 500 && prev_weight < 801 ) begin 
			  cur_grp = 3;
			  if (flag == 1) begin
				  grp3 = grp3 + 1;
				  flag = 0;
			  end		
		  end
		  else if (prev_weight > 800 && prev_weight < 1001 ) begin 
			  cur_grp = 4;
			  if (flag == 1) begin
				  grp4 = grp4 + 1;
				  flag = 0;
			  end		
		  end
		  else if (prev_weight > 1000 && prev_weight < 2001 ) begin 
			  cur_grp = 5;
			  if (flag == 1) begin
				  grp5 = grp5 + 1;
				  flag = 0;
			  end		
		  end
		  else begin
			  cur_grp = 6;
			  if (flag == 1) begin
				  grp6 = grp6 + 1;
				  flag = 0;
			  end		
		  end
	  
  end 
end // End of Block 

endmodule
