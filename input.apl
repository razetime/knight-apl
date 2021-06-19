 ∇ code←Input
 ;code;opt;tieN
 ⍝ Takes input via stdin or a text file, and returns a simple char vector with all the required code.
 ⎕←↑'Options:' '1←File' '2←STDIN' '3←Exit Interpreter'

 opt←⎕

 :If opt=1
   ⍝C:\Users\raghu\Documents\Code\APLPSC21\Phase-1\Q1.apl
   ⎕←'Enter Filename:'
   tieN←⍞ ⎕NTIE 0
   code←∊⎕NREAD tieN 82 (⎕NSIZE tieN)
 :ElseIf opt=2
   ⎕←'Enter Program(list of lines or character matrix):'
   code←∊⎕
 :ElseIf opt=3
   ⎕←'Exiting'
 :Else
   ⎕←'Invalid no. Exiting'
 :EndIf

 ∇