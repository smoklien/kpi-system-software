; a simple hello tasm sample

.386
DSEG SEGMENT USE16
     MESG DB 'hello world', 10, '$'
DSEG ENDS

CSEG SEGMENT USE16
          ASSUME CS:CSEG, DS:DSEG
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