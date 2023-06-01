  .text
  .global _start
  .extern printf

_start:
  .global find_smallest_distance
  .global find_largest_distance
  
ADR X0, x//Get and print smallest indexes
ADR X1, y
ADR X2, N
  LDUR X2, [X2, #0]
  BL find_smallest_distance  
  MOV X2, X1
  MOV X1, X0
ADR X0, smallest
  BL printf

ADR X0, x// Get and print largest indexes
ADR X1, y
ADR X2, N
  LDUR X2, [X2, #0]
  BL find_largest_distance  
  MOV X2, X1
  MOV X1, X0
ADR X0, largest
  BL printf

  MOV X0, #0
  MOV w8, #93
  svc #0

find_smallest_distance: 
ADR X9, filler
LDUR D0, [X9, #0]
  MOV X9, #0
  MOV X10, #0
  MOV X12, #0
smallest_loop1:
  CMP X12 ,X2
  B.EQ find_smallest_distance_end
  ADD X13, X12, #1
smallest_loop2:
  CMP X13, X2
  B.EQ smallest_loop2_end
  LSL X14, X12, #3
  LSL X15, X13, #3 
  ADD X17, X0, X14
LDUR D16, [X17, #0]//Hello
  ADD X17, X1, X14
LDUR D17, [X17, #0]
  ADD X17, X0, X15
LDUR D18, [X17, #0]
  ADD X17, X1, X15
LDUR D19, [X17, #0]
FSUB D16, D16, D18
FSUB D17, D17, D19
FMUL D16, D16, D16
FMUL D16, D16, D16
FADD D16, D16, D17
ADR X16, filler
  LDR D20, [X16]
  FCMP D20, D0
  B.EQ smallest_inside_if
  FCMP D16, D0
  B.LT smallest_inside_if
  B smallest_after_if
smallest_inside_if:
  FMOV D0, D16
  MOV X9, X12
  MOV X10, X13
smallest_after_if: 
ADD X13, X13, #1
  B smallest_loop2
smallest_loop2_end:
ADD X12, X12, #1
  B smallest_loop1
find_smallest_distance_end:
  MOV X0, X9
  MOV X1, X10
  BR lr


find_largest_distance:
ADR X9, filler
  LDR D0, [X9]
  MOV X9, #0
  MOV X10, #0 
  MOV X12, #0
largest_loop1:
  CMP X12 ,X2
  B.EQ find_largest_distance_end 
ADD X13, X12, #1
largest_loop2:
  CMP X13, X2
  B.EQ largest_loop2_end
  LSL X14, X12, #3
  LSL X15, X13, #3 
  ADD X17,X0,X14
LDUR D16, [X17, #0]//X0
  ADD X17, X1, X14
LDUR D17, [X17, #0]//Y0
  ADD X17, X0, X15
LDUR D18, [X17, #0]//X1
  ADD X17, X1, X15
LDUR D19, [X17, #0]//Y1
FSUB D16, D16, D18
FSUB D17, D17, D19
FMUL D16, D16, D16
FMUL D16, D16, D16
FADD D16, D16, D17
ADR X16, filler
LDUR D20, [X16, #0]
  FCMP D20, D0
  B.EQ largest_inside_if
  FCMP D16, D0
  B.GT largest_inside_if
  B largest_after_if
largest_inside_if:
  FMOV D0, D16
  MOV X9, X12
  MOV X10, X13
largest_after_if:
ADD X13, X13, #1
  B largest_loop2
largest_loop2_end:
ADD X12, X12, #1
  B largest_loop1
find_largest_distance_end:
  MOV X0, X9
  MOV X1, X10
  BR lr
  
  .data
largest: .string "Largest distance between points: %d and %d\n"
smallest: .string "Smallest distance between points: %d and %d\n"
filler: .double -1.0

N: .dword 8
x: .double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505
y: .double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196

  .end
