 ∇ Run ast
   ;Block;Call;Output;Quit;Length;Dump;Eval;Not;While;Plus;Minus;Div;Mul;Mod;Pow;Less;Great;Rand;And;Or;K;Equ;If;Get;Sub;Prompt;kns;keys;trans;convert;text
   ⍝ symbols ← 'BCOQLDE`!' 'W+-/*%^<>?&|;=' 'IG' (,'S')
   keys ← 'ABCOQLDE`!W+-/*%^<>?&|;=IGSP:'
   trans ← '⎕UCS' 'Block' 'Call' 'Output' 'Quit' 'Length' 'Dump' 'Eval' '⎕SH' 'Not' 'While' 'Plus' 'Minus' 'Div' 'Mul' 'Mod' 'Pow' 'Less' 'Great' 'Rand' 'And' 'Or' 'K' 'Equ' 'If' 'Get' 'Sub' '⎕' 'I'
   ⍝ ⎕←keys,⍪trans
   ⍝ ⎕←⊃,/';'∘,¨trans
   ⍝ output←''
   
   'kns' ⎕NS ⍬ ⍝ Knight namespace to freely create variables in
   convert←{
     'R'=⊃⊃⍵:'((',⍵,')0)'
     '='=⊃⊃⍵:(')',⍨'(kns.',(2⊃⍵),'⊢←',∇3⊃⍵)⊣kns.⍎∊(2⊃⍵),'←0'
     'I'=⊃⊃⍵:')',⍨'(({',(∇3⊃⍵),'}If{',(∇4⊃⍵)'})',∇2⊃⍵     ⍝ If and while are dops, so we need to shuffle around the inputs a bit
     'W'=⊃⊃⍵:'})0)',⍨'(({~',(∇2⊃⍵),'}While{',∇¨2↓⍵
     'B'=⊃⊃⍵:''')',⍨'(Block''',∇¨1↓⍵ ⍝ Blocks are effectively strings, which means eval can work on them
                                     ⍝ no first class functions, so this is the simplest way
     ';'=⊃⊃⍵:')',⍨'(',{⍺,'⊣',⍵}/⌽∇¨1↓⍵
     ':'=⊃⊃⍵:')',⍨'(',∇¨1↓⍵
     ⊃(⊃⍵)∊keys:')',⍨'(',(trans[keys⍳⊃⍵]),∇¨1↓⍵
     '"'''∊⍨⊃⊃⍵:'''',⍨'''',(''''⎕R'''''')1↓¯1↓⍵
     (⊃⊃⍵)∊'abcdefghijklmnopqrstuvwxyz':'(kns.',⍵,')'
     '(',⍵,')'
   }
   ⎕←text←∊convert ast ⍝ Final transpiled APL code
   ⍝ Helpers
   CastBool←{(0=⍵)∨(''=⍵):0⋄1}
   CastInt←{83=⎕DR ⍵:⍵⋄⍎⊃('\d+'⎕S'&')⍵}
   FALSE←0
   NULL←0

   ⍝ Builtin functions
   Block←{⍵}
   Call←{⍎⍵}
   Output←{⎕←⍵}
   Quit←{⎕←⍵⋄→QuitLabel}
   Length←{≢⍵}
   Dump←{CastBool ⍵:⎕←'truthy'⋄⎕←'falsy'}
   Eval←{Run Parse ⍵}
   Not←{CastBool ⍵:0⋄1}
   While←{⍵⍵⍣⍺⍺⊢⍵}
   Plus←{83=⎕DR⊃⍵:(⊃⍵)+CastInt 2⊃⍵⋄(⊃⍵),⍕2⊃⍵} ⍝ need to special case for strings, same for mul
   Minus←{(⊃⍵)+CastInt 2⊃⍵}
   Div←{⌊(⊃⍵)÷CastInt 2⊃⍵}
   Mul←{83=⎕DR⊃⍵:(⊃⍵)×CastInt 2⊃⍵⋄⊃,/(CastInt 2⊃⍵)/⊂⊃⍵}
   Mod←{(CastInt 2⊃⍵)|⊃⍵}
   Pow←{(⊃⍵)*CastInt 2⊃⍵}
   Less←{</⍋⍵}
   Great←{>/⍋⍵}
   Rand←{¯1+?32767}
   And←∧/CastBool¨
   Or←∨/CastBool¨
   If←{⍵:⍺⍺0⋄⍵⍵0}
   Get←{(3⊃⍵)↑(2⊃⍵)↓(⊃⍵)}
   Sub←{(4⊃⍵)@((2⊃⍵)+⍳3⊃⍵)⊢⊃⍵}

   ⍬⊣⍎text

   QuitLabel:
   
 ∇