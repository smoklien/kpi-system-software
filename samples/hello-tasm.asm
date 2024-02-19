; a simple hello tasm sample

STSEG SEGMENT USE16 STACK
           DB 64 DUP ( "STACK" )
STSEG ENDS

DSEG SEGMENT USE16
     MESG DB 'hello world', 11, '$'
DSEG ENDS

CSEG SEGMENT USE16
          ASSUME CS:CSEG, DS:DSEG, SS:STSEG
     BEG: MOV    AX, DSEG
          MOV    DS, AX
          MOV    CX, 3
     LAST:MOV    AH, 9
          MOV    DX, OFFSET MESG
          INT    21H
          LOOP   LAST
          MOV    AH,4CH
          INT    21H                            ; BACK TO DOS
CSEG ENDS
END BEG