 ∇ ast←Parse input
   ;UP;nullary;unary;binary;ternary;quaternary
   ⍝ Expects a simple character array.

   ⍝ Remove comments
   input ← ('[^"].*\K#.*$' ⎕R '')input

   ⍝ Regex literals - partly taken from readme
   UP ← '[A-Z_]*'
   nullary ← '[0-9]+|''[^'']*''|"[^"]*"|[a-z_][a-z_0-9]*|[TFNPR]',UP
   unary ← '[ABCOQLDE]',UP,'|[`!]'
   binary ← 'W',UP,'|[\+\-\*\/%\^<>\?&\|;=]'
   ternary ← '[IG]',UP
   quaternary ← 'S',UP

   tokenRegex ← ⊃{⍺,'|',⍵}/(nullary unary binary ternary quaternary)
   ⍝ ⎕←tokenRegex
   tokens←(tokenRegex ⎕S '&')input
   ast←⍬
   symbols ← 'ABCOQLDE`!' 'W+-/*%^<>?&|;=' 'IG' (,'S')
   gen←{
     arity ← ⊃⍸(⊃⍵)∘∊¨symbols
     arity=0: ast⊢←(⊂⍵),ast
     ast⊢←(⊂(⊃⍵),⍥⊆(arity↑ast)),(arity↓ast)

   }
   gen¨⌽tokens
   ast←⊃ast
 ∇