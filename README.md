# knight-apl
A [Knight](https://github.com/sampersand/knight) implementation written in Dyalog APL.

To run, use `⎕FIX` to add `input.apl`, `parser.apl`, `run.apl` to your workspace.

Run `Input` for a simple interactive interpreter.

The `Parse` function will generate an AST for vaild Knight code.

The `Run` function will run an AST created from the `Parse` function, so `Run Parse <knight code>` will work as well.
